require 'rails_helper'

RSpec.describe Event::Operation::Close do
  let(:event_admin) { create :user }
  let(:event_member1) { create :user }
  let(:event_member2) { create :user }
  let(:event_member3) { create :user }
  let(:default_params) { attributes_for :event, date: (Time.now + 1.day).strftime('%F %H:%M') }
  let!(:event) { Event::Operation::Create.call(current_user: event_admin, params: default_params)[:model] }

  subject(:operation) { described_class.call(params: params, current_user: user) }

  describe '.call' do
    describe 'valid params' do
      let(:user) { event_admin }
      let(:params) { { id: event.id } }

      describe '2 event members' do
        before do
          UserEvent::Operation::Create.call(current_user: event_member1,
                                            params: { event_id: event.id, user_id: event_member1.id })
          UserEvent::Operation::Update.call(current_user: event_member1,
                                            params: { event_id: event.id, user_id: event_member1.id, payment: 300.00 })
        end
        it { should be_success }
        it { expect { operation }.to change(Debt, :count).by(1) }
        it { expect(operation[:debts].map(&:value).map(&:format).sort).to match_array ['150.00 ₽'] }
      end

      describe '3 event members' do
        before do
          [{ current_user: event_member1, payment: 100 }, { current_user: event_member2, payment: 200 }].each do |h|
            UserEvent::Operation::Create.call(current_user: h[:current_user],
                                              params: { event_id: event.id, user_id: h[:current_user].id })
            UserEvent::Operation::Update.call(
              current_user: h[:current_user],
              params: { event_id: event.id, user_id: h[:current_user].id, payment: h[:payment] }
            )
          end
        end

        it { should be_success }
        it { expect { operation }.to change(Debt, :count).by(1) }
        it { expect(operation[:debts].map(&:value).map(&:format).sort).to match_array ['100.00 ₽'] }
      end

      describe '3 event members' do
        before do
          [{ current_user: event_member1, payment: 50 }, { current_user: event_member2, payment: 250 }].each do |h|
            UserEvent::Operation::Create.call(current_user: h[:current_user],
                                              params: { event_id: event.id, user_id: h[:current_user].id })
            UserEvent::Operation::Update.call(
              current_user: h[:current_user],
              params: { event_id: event.id, user_id: h[:current_user].id, payment: h[:payment] }
            )
          end
        end

        it { should be_success }
        it { expect { operation }.to change(Debt, :count).by(2) }
        it { expect(operation[:debts].map(&:value).map(&:format).sort).to match_array ['100.00 ₽', '50.00 ₽'] }
      end

      describe '4 event members with 1 cost' do
        before do
          [{ current_user: event_member1, payment: 300 }, { current_user: event_member2, payment: 200 }].each do |h|
            UserEvent::Operation::Create.call(current_user: h[:current_user],
                                              params: { event_id: event.id, user_id: h[:current_user].id })
            UserEvent::Operation::Update.call(
              current_user: h[:current_user],
              params: { event_id: event.id, user_id: h[:current_user].id, payment: h[:payment] }
            )
            UserEvent::Operation::Create.call(current_user: event_member3,
                                              params: { event_id: event.id, user_id: event_member3.id })
            UserEvent::Operation::Update.call(
              current_user: event_member3,
              params: { event_id: event.id, user_id: event_member3.id, cost: 150 }
            )

          end
        end

        it { should be_success }
        it { expect { operation }.to change(Debt, :count).by(4) }
        it { expect(operation[:debts].map(&:value).map(&:format).sort).to match_array ['105.00 ₽', '37.50 ₽', '45.00 ₽', '87.50 ₽'] }
      end
    end

    describe 'invalid params' do
      describe 'event does not exist' do
        let(:user) { event_member1 }
        let(:params) { { id: 1234 } }

        it_behaves_like 'invalid close event operation'
      end

      describe 'different user' do
        let(:user) { event_member1 }
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
        it { expect(operation_errors(operation)).to include 'Event is already close' }
      end
    end
  end
end