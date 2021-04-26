require 'rails_helper'

RSpec.describe Refill::Operation::Rollback do
  describe '.call' do
    let!(:debt) { create :debt, value: 300 }
    subject(:operation) { described_class.call(params: params) }

    describe 'valid params' do
      describe 'update Debt +' do
        let!(:refill) { create :refill, value: 100, debt: debt }
        let(:params) { { id: refill.id } }

        it { should be_success }
        it { expect(operation[:debt].value.format).to eq '200.00 ₽' }
        it { expect(operation[:refill].status).to eq :rollback }
      end

      describe 'update Debt -' do
        let!(:refill) { create :refill, value: -100, debt: debt }
        let(:params) { { id: refill.id } }

        it { should be_success }
        it { expect(operation[:debt].value.format).to eq '400.00 ₽' }
        it { expect(operation[:refill].status).to eq :rollback }
      end
    end

    describe 'invalid params' do
      describe '0  Refill value' do
        let!(:refill) { create :refill, value: 0, debt: debt }
        let(:params) { { id: refill.id } }

        it { should be_failure }
        it { expect(operation[:debt].value.format).to eq '300.00 ₽' }
        it { expect(operation_errors(operation)).to include 'Value invalid, Debt sum must be greater then 0' }
        it { expect(operation[:refill].status).to eq :created }
      end
    end
  end
end