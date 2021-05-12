require 'rails_helper'

RSpec.describe Debt::Operation::Create do
  before_all do
    @creditor = create :user
    @borrower = create :user
  end
  let(:borrower) { @borrower }
  let(:creditor) { @creditor }

  describe '.call' do
    subject(:operation) { described_class.call(params: params) }

    describe 'valid params' do
      describe 'create new Debt' do
        let(:params) { { borrower: borrower, creditor: creditor, value: Money.new(300_00, 'RUB') } }

        it_behaves_like 'success create debt operation', debt_count: 1, refill_count: 1
        it 'should assign attributes' do
          expect(operation[:debt].value.format).to eq '300.00 ₽'
          expect(operation[:refill].value.format).to eq '300.00 ₽'
        end
      end

      describe 'accelerate debt' do
        let!(:debt) { create :debt, creditor: creditor, borrower: borrower, value: Money.new(300_00, 'RUB') }
        let(:params) { { borrower: borrower, creditor: creditor, value: Money.new(300_00, 'RUB') } }

        it_behaves_like 'success create debt operation', debt_count: 0, refill_count: 1
        it { expect(operation[:debt].value.format).to eq '600.00 ₽' }
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