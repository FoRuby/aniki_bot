require 'rails_helper'

RSpec.describe Debt::Operation::Update do
  let(:creditor) { create :user }
  let(:borrower) { create :user }
  let!(:debt) { create :debt, creditor: creditor, borrower: borrower, value: 100 }

  describe '.call' do
    subject(:operation) { described_class.call(params: params) }

    describe 'valid params' do
      describe 'update Debt +' do
        let(:params) { { borrower_id: borrower.id, creditor_id: creditor.id, value: Money.new(300_00, 'RUB') } }

        it { should be_success }
        it { expect(operation[:debt].value.format).to eq '400.00 ₽' }
      end

      describe 'update Debt -' do
        let(:params) { { borrower_id: borrower.id, creditor_id: creditor.id, value: Money.new(-100_00, 'RUB') } }

        it { should be_success }
        it { expect(operation[:debt].value.format).to eq '0.00 ₽' }
      end
    end

    describe 'invalid params' do
      describe 'empty debt value' do
        let(:params) { { borrower_id: borrower.id, creditor_id: creditor.id, value: Money.new(-500_00, 'RUB') } }

        it { should be_failure }
        it { expect(operation_errors(operation)).to include 'Value invalid, Debt sum must be greater then 0' }
      end
    end
  end
end