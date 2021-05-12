require 'rails_helper'

RSpec.describe Refill::Operation::Create do
  before_all do
    @borrower = create_default :user
    @creditor = create_default :user
  end
  let(:borrower) { @borrower }
  let(:creditor) { @creditor }

  subject(:operation) { described_class.call(params: params) }
  describe '.call' do
    describe 'valid params' do
      describe 'create Refill' do
        let(:debt) { create :debt, borrower: borrower, creditor: creditor, value: 0 }
        let(:params) { { debt_id: debt.id, value: Money.new(300_00, 'RUB') } }

        it_behaves_like 'success create refill operation'
        it 'should assign attributes' do
          expect(operation[:debt].value.format).to eq '300.00 ₽'
          expect(operation[:refill].value.format).to eq '300.00 ₽'
        end
      end

      describe 'create Refill' do
        subject(:operation) { described_class.call(debt: debt, params: params) }

        let!(:debt) { create :debt, borrower: borrower, creditor: creditor, value: 0 }
        let(:params) { { value: Money.new(300_00, 'RUB') } }

        it_behaves_like 'success create refill operation'
        it 'should assign attributes' do
          expect(operation[:debt].value.format).to eq '300.00 ₽'
          expect(operation[:refill].value.format).to eq '300.00 ₽'
        end
      end

      describe 'accelerate debt +' do
        let!(:debt) { create :debt, borrower: borrower, creditor: creditor, value: 100 }
        let(:params) { { debt_id: debt.id, value: Money.new(300_00, 'RUB') } }

        it_behaves_like 'success create refill operation'
        it 'should assign attributes' do
          expect(operation[:debt].value.format).to eq '400.00 ₽'
          expect(operation[:refill].value.format).to eq '300.00 ₽'
        end
      end

      describe 'accelerate debt -' do
        let!(:debt) { create :debt, borrower: borrower, creditor: creditor, value: 300 }
        let(:params) { { debt_id: debt.id, value: Money.new(-100_00, 'RUB') } }

        it_behaves_like 'success create refill operation'
        it 'should assign attributes' do
          expect(operation[:debt].value.format).to eq '200.00 ₽'
          expect(operation[:refill].value.format).to eq '-100.00 ₽'
        end
      end
    end
  end
end