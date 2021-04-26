require 'rails_helper'

RSpec.describe Refill::Operation::Create do
  describe '.call' do
    subject(:operation) { described_class.call(params: params) }

    describe 'valid params' do
      describe 'create Refill' do
        let!(:debt) { create :debt, value: 0 }
        let(:params) { { debt_id: debt.id, value: Money.new(300_00, 'RUB') } }

        it { should be_success }
        it { expect { operation }.to change(Refill, :count).by(1) }
        it { expect(operation[:debt].value.format).to eq '300.00 ₽' }
        it { expect(operation[:refill].value.format).to eq '300.00 ₽' }
      end

      describe 'create Refill' do
        subject(:operation) { described_class.call(debt: debt, params: params) }

        let!(:debt) { create :debt, value: 0 }
        let(:params) { { value: Money.new(300_00, 'RUB') } }

        it { should be_success }
        it { expect { operation }.to change(Refill, :count).by(1) }
        it { expect(operation[:debt].value.format).to eq '300.00 ₽' }
        it { expect(operation[:refill].value.format).to eq '300.00 ₽' }
      end

      describe 'accelerate debt +' do
        let!(:debt) { create :debt, value: 100 }
        let(:params) { { debt_id: debt.id, value: Money.new(300_00, 'RUB') } }

        it { should be_success }
        it { expect { operation }.to change(Refill, :count).by(1) }
        it { expect(operation[:debt].value.format).to eq '400.00 ₽' }
        it { expect(operation[:refill].value.format).to eq '300.00 ₽' }
      end

      describe 'accelerate debt -' do
        let!(:debt) { create :debt, value: 300 }
        let(:params) { { debt_id: debt.id, value: Money.new(-100_00, 'RUB') } }

        it { should be_success }
        it { expect { operation }.to change(Refill, :count).by(1) }
        it { expect(operation[:debt].value.format).to eq '200.00 ₽' }
        it { expect(operation[:refill].value.format).to eq '-100.00 ₽' }
      end
    end
  end
end