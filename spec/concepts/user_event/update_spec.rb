require 'rails_helper'

RSpec.describe UserEvent::Operation::Update do
  let(:event_admin) { create :user }
  let(:event_member) { create :user }
  let!(:event) do
    Event::Operation::Create.call(current_user: event_admin, params: attributes_for(:event))[:model]
  end
  let!(:user_event) do
    UserEvent::Operation::Create.call(current_user: event_member,
                                      params: { user_id: event_member.id, event_id: event.id })[:model]
  end

  describe '.call' do
    subject(:operation) { described_class.call(params: params, current_user: user) }

    describe 'valid params' do
      describe 'payment as Money object' do
        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id, payment: Money.new(33_333, 'RUB') } }

        it { should be_success }
        it { expect(operation[:model].payment.format).to eq '333.33 ₽' }
      end

      describe 'payment as float' do
        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id, payment: 300.33 } }

        it { should be_success }
        it { expect(operation[:model].payment.format).to eq '300.33 ₽' }
      end

      describe 'accelerate payment' do
        before do
          UserEvent::Operation::Update.call(current_user: event_member,
                                            params: { payment: 300, user_id: event_member.id, event_id: event.id })
        end

        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id, payment: 300 } }

        it { should be_success }
        it { expect(operation[:model].payment.format).to eq '600.00 ₽' }
      end
    end

    describe 'invalid params' do
      describe 'invalid payment format' do
        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id, payment: 'foobar' } }

        it { should be_success }
        it { expect(operation[:model].payment.format).to eq '0.00 ₽' }
      end

      describe 'negative payment' do
        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id, payment: -300 } }

        it { should be_success }
        it { expect(operation[:model].payment.format).to eq '0.00 ₽' }
      end

      describe 'invalid params' do
        describe 'different user' do
          let(:user) { create :user }
          let(:params) { { user_id: event_member.id, event_id: event.id, payment: 300 } }

          it { should be_failure }
          it { expect(operation[:"result.policy.default"]).to be }
        end

        describe 'closed event' do
          before { event.update(status: :close) }

          let(:user) { event_member }
          let(:params) { { user_id: event_member.id, event_id: event.id, payment: 300 } }

          it { should be_failure }
          it { expect(operation_errors(operation)).to include 'Event is already close' }
        end
      end
    end
  end
end