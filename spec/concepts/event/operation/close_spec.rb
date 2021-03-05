require 'rails_helper'

RSpec.describe Event::Operation::Close do
  let(:event_admin) { create :user }
  let(:event_member) { create :user }
  let(:default_params) { attributes_for :event, date: (Time.now + 1.day).strftime('%F %H:%M') }
  let!(:event) { Event::Operation::Create.call(current_user: event_admin, params: default_params)[:model] }

  before do
    UserEvent::Operation::Create.call(current_user: event_member,
                                      params: { event_id: event.id, user_id: event_member.id })
    UserEvent::Operation::Update.call(current_user: event_member,
                                      params: { event_id: event.id, user_id: event_member.id, payment: 300.00 })
  end

  subject(:operation) { described_class.call(params: params, current_user: user) }

  describe '.call' do
    describe 'valid params' do
      let(:user) { event_admin }
      let(:params) { { id: event.id } }

      it { should be_success }
      it { expect { operation }.to change(Debt, :count).by(1) }

      it 'should assign debt attributes' do
        debt = operation[:debts].last
        expect(debt.borrower).to eq event_admin
        expect(debt.creditor).to eq event_member
        expect(debt.debt.format).to eq '150.00 ₽'
      end
    end

    describe 'invalid params' do
      describe 'event does not exist' do
        let(:user) { event_member }
        let(:params) { { id: 1234 } }

        it_behaves_like 'invalid close event operation'
      end

      describe 'different user' do
        let(:user) { event_member }
        let(:params) { { id: event.id } }

        it_behaves_like 'invalid close event operation'
      end

      describe 'closed event' do
        before do
          event.update(status: :close)
        end
        let(:user) { event_admin }
        let(:params) { { id: event.id } }

        it_behaves_like 'invalid close event operation'
        it 'should contain errors' do
          expect(operation_errors(operation)).to include 'Event is already close'
        end
      end
    end
  end
end