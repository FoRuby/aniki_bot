require 'rails_helper'

RSpec.describe UserEvent::Operation::AddAdmin do
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
      let(:user) { event_admin }
      let(:params) { { user_id: event_member.id, event_id: event.id } }

      it { should be_success }
      it 'should assign admin role to event member' do
        operation
        expect(event_member.has_role?(:admin, event)).to be_truthy
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