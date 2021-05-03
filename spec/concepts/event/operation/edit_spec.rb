require 'rails_helper'

RSpec.describe Event::Operation::Edit do
  let(:event_admin) { create :user }
  let!(:event) do
    Event::Operation::Create.call(current_user: event_admin, params: attributes_for(:event))[:model]
  end

  subject(:operation) { described_class.call(params: params, current_user: user) }

  describe '.call' do
    describe 'valid params' do
      let(:user) { event_admin }
      let(:params) { { id: event.id } }

      it { should be_success }
      it { expect(operation[:model]).to eq event }
    end

    describe 'invalid params' do
      describe 'event does not exist' do
        let(:user) { event_admin }
        let(:params) { { id: 1234 } }

        it { should be_failure }
        it { expect(operation[:model]).to be_nil }
      end

      describe 'different user' do
        let(:user) { create :user }
        let(:params) { { id: event.id } }

        it { should be_failure }
        it { expect(operation['result.policy.default']).to be }
      end

      describe 'closed event' do
        before do
          event.update(status: :close)
        end
        let(:user) { event_admin }
        let(:params) { { id: event.id } }

        it { should be_failure }
        it { expect(operation_errors(operation)).to include 'Event is already close' }
      end
    end
  end
end