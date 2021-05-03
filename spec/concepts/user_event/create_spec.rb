require 'rails_helper'

RSpec.describe UserEvent::Operation::Create do
  let(:event_admin) { create :user }
  let!(:event) do
    Event::Operation::Create.call(current_user: event_admin, params: attributes_for(:event))[:model]
  end

  describe '.call' do
    subject(:operation) { described_class.call(params: params, current_user: user) }

    describe 'valid params' do
      let(:user) { create :user }
      let(:params) { { user_id: user.id, event_id: event.id } }

      it { should be_success }
      it { expect { operation }.to change(UserEvent, :count).by(1) }
    end

    describe 'invalid params' do
      describe 'nil user' do
        let(:user) { nil }
        let(:params) { { user_id: nil, event_id: event.id } }

        it_behaves_like 'invalid create user_event operation'
        it { expect(operation['result.policy.default']).to be }
      end

      describe 'not existed event_id' do
        let(:user) { create :user }
        let(:params) { { user_id: user.id, event_id: 1234 } }

        it_behaves_like 'invalid create user_event operation'
        it { expect(operation_errors(operation)).to include 'Event Id Could not find Event with id = 1234' }
      end

      describe 'not existed user_id' do
        let(:user) { create :user }
        let(:params) { { user_id: 1234, event_id: event.id } }

        it_behaves_like 'invalid create user_event operation'
        it { expect(operation_errors(operation)).to include 'User Id Could not find User with id = 1234' }
      end

      describe 'closed event' do
        before { event.update(status: :close) }

        let(:user) { create :user }
        let(:params) { { user_id: user.id, event_id: event.id } }

        it_behaves_like 'invalid create user_event operation'
        it { expect(operation_errors(operation)).to include 'Event is already close' }
      end

      describe 'user already event member' do
        before { UserEvent.create(user_id: user.id, event_id: event.id) }

        let(:user) { create :user }
        let(:params) { { user_id: user.id, event_id: event.id } }

        it_behaves_like 'invalid create user_event operation'
        it { expect(operation_errors(operation)).to include 'User is already involved in the event' }
      end
    end
  end
end