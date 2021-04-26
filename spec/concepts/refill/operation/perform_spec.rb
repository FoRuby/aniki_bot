require 'rails_helper'

RSpec.describe Refill::Operation::Perform do
  describe '.call' do
    subject(:operation) { described_class.call(params: params) }

    describe 'valid params' do
      describe 'update Debt' do
        let!(:debt) { create :debt, value: 0 }
        let!(:refill) { create :refill, value: 100, debt: debt }
        let(:params) { { id: refill.id } }

        it { should be_success }
        it { expect(operation[:debt].value.format).to eq '100.00 ₽' }
        it { expect(operation[:refill].status).to eq :completed }
      end
    end

    describe 'invalid params' do
      describe '0  Refill value' do
        let!(:debt) { create :debt, value: 0 }
        let!(:refill) { create :refill, value: 0, debt: debt }
        let(:params) { { id: refill.id } }

        it { should be_failure }
        it { expect(operation[:debt].value.format).to eq '0.00 ₽' }
        it { expect(operation_errors(operation)).to include 'Value invalid, Debt sum must be greater then 0' }
        it { expect(operation[:refill].status).to eq :created }
      end
    end
  end
end