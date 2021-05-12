require 'rails_helper'

RSpec.describe UserEvent::Operation::Create do
  before_all do
    @admin = create :user
    @user = create :user
    @event = create :event, :with_admin, user: @admin
  end
  let(:admin) { @admin }
  let(:user) { @user }
  let(:event) { @event }

  describe '.call' do
    subject(:operation) { described_class.call(params: params, current_user: user) }

    describe 'valid params' do
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
        let(:params) { { user_id: user.id, event_id: 1234 } }

        it_behaves_like 'invalid create user_event operation'
        it { expect(operation_errors(operation)).to include 'Event Id Could not find Event with id = 1234' }
      end

      describe 'not existed user_id' do
        let(:params) { { user_id: 1234, event_id: event.id } }

        it_behaves_like 'invalid create user_event operation'
        it { expect(operation_errors(operation)).to include 'User Id Could not find User with id = 1234' }
      end


      describe 'user already event member' do
        let(:user) { admin }
        let(:params) { { user_id: user.id, event_id: event.id } }

        it_behaves_like 'invalid create user_event operation'
        it { expect(operation_errors(operation)).to include 'User is already involved in the event' }
      end

      describe 'closed event' do
        before_all do
          @admin = create :user
          @event = create :event, :close, :with_admin, user: @admin
        end

        let(:params) { { user_id: user.id, event_id: event.id } }

        it_behaves_like 'invalid create user_event operation'
        it { expect(operation_errors(operation)).to include 'Event is already close' }
      end
    end
  end
end
