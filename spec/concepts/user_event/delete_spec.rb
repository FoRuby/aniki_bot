require 'rails_helper'

RSpec.describe UserEvent::Operation::Delete do
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
      describe 'event member try delete user_event' do
        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id } }

        it_behaves_like 'valid delete user_event operation'
      end

      describe 'event admin try delete user_event' do
        let(:user) { event_admin }
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
        before { event.update(status: :close) }

        let(:user) { event_member }
        let(:params) { { user_id: user.id, event_id: event.id } }

        it_behaves_like 'invalid delete user_event operation'
        it { expect(operation_errors(operation)).to include 'Event is already close' }
      end
    end
  end
end