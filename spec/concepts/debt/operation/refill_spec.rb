require 'rails_helper'

RSpec.describe Debt::Operation::Refill do
  describe '.call' do
    describe 'valid params' do
      describe 'via Debt' do
        subject(:operation) { described_class.call(debt: debt, params: params) }

        let!(:debt) { create :debt, value: 300 }
        let(:params) { { value: 100 } }

        it { should be_success }
        it { expect { operation }.to change(Refill, :count).by(1) }
        it { expect(operation[:model].value.format).to eq '200.00 ₽' }
      end

      describe 'via creditor_id and borrower_id' do
        subject(:operation) { described_class.call(params: params) }

        let(:creditor) { create :user }
        let(:borrower) { create :user }
        let!(:debt) { create :debt, creditor: creditor, borrower: borrower, value: 300 }
        let(:params) { { creditor_id: creditor.id, borrower_id: borrower.id, value: 100 } }

        it { should be_success }
        it { expect { operation }.to change(Refill, :count).by(1) }
        it { expect(operation[:model].value.format).to eq '200.00 ₽' }
      end
    end

    describe 'invalid params' do
      let!(:debt) { create :debt, value: 300 }

      subject(:operation) { described_class.call(debt: debt, params: params) }

      describe 'negative refill value' do
        let(:params) { { value: -100 } }

        it { should be_failure }
        it { expect { operation }.to_not change(Refill, :count) }
        it { expect(operation[:model].value.format).to eq '300.00 ₽' }
        it { expect(operation_errors(operation)).to include 'Refills Value invalid, must be greater then 0' }
      end

      describe 'overcup refill value' do
        let(:params) { { value: 500 } }

        it { should be_failure }
        it { expect { operation }.to_not change(Refill, :count) }
        it { expect(operation[:model].value.format).to eq '300.00 ₽' }
        it { expect(operation_errors(operation)).to include 'Value invalid, Debt sum must be greater then 0' }
      end
    end
  end
end