require 'rails_helper'

RSpec.describe Event::Operation::Update do
  before_all do
    @admin = create :user
    @event = create :event, :with_admin, user: @admin
  end
  let(:admin) { @admin }
  let(:event) { @event }

  subject(:operation) { described_class.call(current_user: user, params: params) }

  describe '.call' do
    let(:user) { admin }

    describe 'valid params' do
      let(:params) { attributes_for(:event).merge({ id: event.id }) }

      it { should be_success }
      it { expect(operation[:model]).to eq event }
    end

    describe 'invalid params' do
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

      describe 'empty event name' do
        let(:params) { attributes_for(:event).merge({ id: event.id, name: '' }) }

        it { should be_failure }
        it { expect(operation_errors(operation)).to include 'Name must be filled' }
      end

      describe 'invalid date format' do
        let(:params) { { id: event.id, name: 'test', date: 'foobar' } }

        it { should be_failure }
        it { expect(operation_errors(operation)).to include 'Date must be a time' }
      end

      describe 'invalid past date' do
        let(:params) { attributes_for(:event, :past).merge({ id: event.id }) }

        it { should be_failure }
        it { expect(operation_errors(operation)).to include 'Date must be in future' }
      end

      describe 'closed event' do
        let!(:event) { create :event, :close, :with_admin, user: admin }
        let(:params) { attributes_for(:event).merge({ id: event.id }) }

        it { should be_failure }
        it { expect(operation_errors(operation)).to include 'Event is already close' }
      end
    end
  end
end
