require 'rails_helper'

RSpec.describe Debt::Operation::Create do
  let(:creditor) { create :user }
  let(:borrower) { create :user }

  describe '.call' do
    subject(:operation) { described_class.call(params: params) }

    describe 'valid params' do
      describe 'create new Debt without coefficient' do
        let(:params) { { borrower: borrower, creditor: creditor, value: Money.new(30_000, 'RUB') } }

        it { should be_success }
        it { expect { operation }.to change(Debt, :count).by(1) }
        it { expect(operation[:model].value.format).to eq '300.00 ₽' }
      end

      describe 'create new Debt with coefficient' do
        let(:params) do
          { borrower: borrower, coefficient: 0.5, creditor: creditor, value: Money.new(30_000, 'RUB') }
        end

        it { should be_success }
        it { expect { operation }.to change(Debt, :count).by(1) }
        it { expect(operation[:model].value.format).to eq '150.00 ₽' }
      end

      describe 'accelerate debt' do
        let(:params) { { creditor: creditor, borrower: borrower, value: Money.new(30_000, 'RUB') } }
        before do
          Debt::Operation::Create.call(params: params)
        end

        it { should be_success }
        it { expect { operation }.not_to change(Debt, :count) }
        it { expect(operation[:model].value.format).to eq '600.00 ₽' }
      end
    end

    describe 'invalid params' do
      describe 'empty debt value' do
        let(:params) { { creditor: creditor, borrower: borrower } }

        it { should be_failure }
        it { expect(operation_errors(operation)).to include 'Value invalid, Debt sum must be greater then 0' }
        it { expect { operation }.not_to change(Debt, :count) }
      end
    end
  end
end