require 'rails_helper'

RSpec.describe UserEvent::Operation::Update do
  before_all do
    @admin = create :user
    @event = create :event, :with_admin, user: @admin
    @event_member = create :user
    @user_event = create :user_event, event: @event, user: @event_member
  end
  let(:admin) { @admin }
  let(:event) { @event }
  let(:event_member) { @event_member }
  let(:user_event) { @user_event }

  describe '.call' do
    subject(:operation) { described_class.call(params: params, current_user: user) }

    describe 'valid params' do
      describe 'payment as Money object' do
        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id, payment: Money.new(333_33, 'RUB') } }

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
        before_all do
          @event_member = create :user
          @user_event = create :user_event, event: @event, user: @event_member, payment: 300
        end

        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id, payment: 300 } }

        it { should be_success }
        it { expect(operation[:model].payment.format).to eq '600.00 ₽' }
      end
    end

    describe 'invalid params' do
      # in dry check the parameters of money are loaded
      describe 'invalid payment format' do
        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id, payment: 'foobar' } }

        it { should be_failure }
        it { expect(operation_errors(operation)).to include 'Payment invalid. Event payment sum must be greater then 0' }
      end

      describe 'negative first payment' do
        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id, payment: -300 } }

        it { should be_failure }
        it { expect(operation_errors(operation)).to include 'Payment invalid. Event payment sum must be greater then 0' }
      end

      describe 'negative second payment' do
        before_all do
          @event_member = create :user
          @user_event = create :user_event, event: @event, user: @event_member, payment: 300
        end

        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id, payment: -200 } }

        it { should be_success }
        it { expect(operation[:model].payment.format).to eq '100.00 ₽' }
      end

      describe 'invalid params' do
        describe 'different user' do
          let(:user) { create :user }
          let(:params) { { user_id: event_member.id, event_id: event.id, payment: 300 } }

          it { should be_failure }
          it { expect(operation[:"result.policy.default"]).to be }
        end

        describe 'closed event' do
          before_all do
            @admin = create :user
            @event = create :event, :close, :with_admin, user: @admin
            @event_member = create :user
            @user_event = create :user_event, event: @event, user: @event_member
          end

          let(:user) { event_member }
          let(:params) { { user_id: event_member.id, event_id: event.id, payment: 300 } }

          it { should be_failure }
          it { expect(operation_errors(operation)).to include 'Event is already close' }
        end
      end
    end
  end
end