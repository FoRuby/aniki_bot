require 'rails_helper'

RSpec.describe Event::Operation::Create do
  let(:user) { create :user }
  subject(:operation) { described_class.call(params: params, current_user: user) }

  describe '.call' do
    describe 'valid params' do
      let(:params) { attributes_for :event }

      it { is_expected.to be_success }
      it { expect { operation }.to change(Event, :count).by(1) }
      it { expect { operation }.to change(UserEvent, :count).by(1) }
    end

    describe 'invalid params' do
      describe 'empty event name' do
        let(:params) { { name: '', date: '2021-01-01 19:00' } }

        it { expect(operation_errors(operation)).to include 'Name must be filled' }
        it_behaves_like 'invalid create event operation'
      end

      describe 'invalid date format' do
        let(:params) { { name: 'test', date: '2021-01-01' } }

        it { expect(operation_errors(operation)).to include 'Date is in invalid format' }
        it_behaves_like 'invalid create event operation'
      end

      describe 'invalid past date' do
        let(:params) { { name: 'test', date: (Time.now - 1.day).strftime('%F %H:%M') } }

        it { expect(operation_errors(operation)).to include 'Date must be in future' }
        it_behaves_like 'invalid create event operation'
      end
    end
  end
end