require 'rails_helper'

RSpec.describe Event::Operation::Update do
  let(:event_admin) { create :user }
  let!(:event) do
    Event::Operation::Create.call(current_user: event_admin, params: attributes_for(:event))[:model]
  end

  subject(:operation) { described_class.call(params: params, current_user: user) }

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
        it { expect(operation[:"result.policy.default"]).to be }
      end

      describe 'closed event' do
        before do
          event.update(status: :close)
        end
        let(:params) { attributes_for(:event).merge({ id: event.id }) }

        it 'should ' do
          pp operation
        end

        it { should be_failure }
        it 'should contain errors' do
          expect(operation_errors(operation)).to include 'Event is already close'
        end
      end

      describe 'empty event name' do
        let(:params) { attributes_for(:event).merge({ id: event.id, name: '' }) }

        it 'should contain errors' do
          expect(operation_errors(operation)).to include 'Name must be filled'
        end
        it_behaves_like 'invalid update event operation'
      end

      describe 'invalid date format' do
        let(:params) { { id: event.id, name: 'test', date: 'foobar' } }

        it 'should contain errors' do
          expect(operation_errors(operation)).to include 'Date is in invalid format'
        end
        it_behaves_like 'invalid update event operation'
      end

      describe 'invalid past date' do
        let(:params) { { id: event.id, name: 'test', date: (Time.now - 1.day).strftime('%F %H:%M') } }

        it 'should contain errors' do
          pp operation
          expect(operation_errors(operation)).to include 'Date must be in future'
        end
        it_behaves_like 'invalid update event operation'
      end
    end
  end
end