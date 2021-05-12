require 'rails_helper'

RSpec.describe UserEvent::Operation::AddAdmin do
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
      describe 'admin' do
        let(:user) { admin }
        let(:params) { { user_id: event_member.id, event_id: event.id } }

        it { should be_success }
        it 'should assign admin role to event member' do
          operation
          expect(event_member.has_role?(:admin, event)).to be_truthy
        end
      end

      describe 'not admin' do
        let(:user) { event_member }
        let(:params) { { user_id: event_member.id, event_id: event.id } }

        it { should be_failure }
        it 'should not assign admin role to event member' do
          operation
          expect(event_member.has_role?(:admin, event)).to be_falsey
        end
      end
    end

    describe 'invalid params' do
      describe 'different user' do
        let(:user) { create :user }
        let(:params) { { user_id: event_member.id, event_id: event.id } }

        it { should be_failure }
        it 'should not assign admin role to event member' do
          operation
          expect(event_member.has_role?(:admin, event)).to be_falsey
        end
      end
    end
  end
end