require 'rails_helper'

RSpec.describe Event::Operation::Update do
  let(:event_admin) { create :user }
  let!(:event) do
    Event::Operation::Create.call(current_user: event_admin, params: attributes_for(:event))[:model]
  end

  subject(:operation) { described_class.call(current_user: user, params: params) }

  describe '.call' do
    describe 'valid params' do
      let(:user) { event_admin }
      let(:params) { attributes_for(:event).merge({ id: event.id }) }

      it { should be_success }
      it { expect(operation[:model]).to eq event }
    end

    describe 'invalid params' do
      let(:user) { event_admin }

      describe 'event does not exist' do
        let(:params) { attributes_for(:event).merge({ id: 1234 }) }

        it { should be_failure }
        it { expect(operation[:model]).to be_nil }
      end

      describe 'different user' do
        let(:user) { create :user }
        let(:params) { attributes_for(:event).merge({ id: event.id }) }

        it { should be_failure }
        it { expect(operation['result.policy.default']).to be }
      end

      describe 'closed event' do
        before do
          event.update(status: :close)
        end
        let(:params) { attributes_for(:event).merge({ id: event.id }) }

        it { should be_failure }
        it { expect(operation_errors(operation)).to include 'Event is already close' }
      end

      describe 'empty event name' do
        let(:params) { attributes_for(:event).merge({ id: event.id, name: '' }) }

        it { expect(operation_errors(operation)).to include 'Name must be filled' }
        it_behaves_like 'invalid update event operation'
      end

      describe 'invalid date format' do
        let(:params) { { id: event.id, name: 'test', date: 'foobar' } }

        it { expect(operation_errors(operation)).to include 'Date must be a time' }
        it_behaves_like 'invalid update event operation'
      end

      describe 'invalid past date' do
        let(:params) { attributes_for(:event, :past).merge({ id: event.id }) }

        it { expect(operation_errors(operation)).to include 'Date must be in future' }
        it_behaves_like 'invalid update event operation'
      end
    end
  end
end