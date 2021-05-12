require 'rails_helper'

RSpec.describe Event::Operation::Edit do
  before_all do
    @admin = create :user
    @event = create :event, :with_admin, user: @admin
  end
  let(:admin) { @admin }
  let(:event) { @event }

  subject(:operation) { described_class.call(params: params, current_user: user) }

  describe '.call' do
    let(:user) { admin }

    describe 'valid params' do
      let(:params) { { id: event.id } }

      it { should be_success }
      it { expect(operation[:model]).to eq event }
    end

    describe 'invalid params' do
      describe 'event does not exist' do
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
        before_all do
          @event = create :event, :close, :with_admin, user: @admin
        end

        let(:params) { { id: event.id } }

        it { should be_failure }
        it { expect(operation_errors(operation)).to include 'Event is already close' }
      end
    end
  end
end