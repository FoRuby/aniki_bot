require 'rails_helper'

RSpec.describe UserEvent::Operation::Delete do
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
      describe 'event member try delete user_event' do
        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id } }

        it_behaves_like 'valid delete user_event operation'
      end

      describe 'event admin try delete user_event' do
        let(:user) { admin }
        let(:params) { { user_id: user.id, event_id: event.id } }

        it_behaves_like 'valid delete user_event operation'
      end
    end

    describe 'invalid params' do
      describe 'different user' do
        let(:user) { create :user }
        let(:params) { { user_id: event_member.id, event_id: event.id } }

        it_behaves_like 'invalid delete user_event operation'
        it { expect(operation['result.policy.default']).to be }
      end

      describe 'closed event' do
        before_all do
          @admin = create :user
          @event = create :event, :close, :with_admin, user: @admin
          @event_member = create :user
          @user_event = create :user_event, event: @event, user: @event_member
        end

        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id } }

        it_behaves_like 'invalid delete user_event operation'
        it { expect(operation_errors(operation)).to include 'Event is already close' }
      end
    end
  end
end