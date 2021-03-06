require 'rails_helper'

RSpec.describe Refill::Operation::Perform do
  before_all do
    @debt = create :debt, value: 0
  end
  let(:debt) { @debt }

  subject(:operation) { described_class.call(params: params) }

  describe '.call' do
    describe 'valid params' do
      describe 'update Debt' do
        let!(:refill) { create :refill, value: 100, debt: debt }
        let(:params) { { id: refill.id } }

        it { should be_success }
        it 'should assign attributes' do
          expect(operation[:debt].value.format).to eq '100.00 ₽'
          expect(operation[:refill].status).to eq :completed
        end
      end
    end

    describe 'invalid params' do
      describe '0  Refill value' do
        let!(:refill) { create :refill, value: 0, debt: debt }
        let(:params) { { id: refill.id } }

        it { should be_failure }
        it 'should assign attributes' do
          expect(operation[:debt].value.format).to eq '0.00 ₽'
          expect(operation[:refill].status).to eq :created
        end
        it { expect(operation_errors(operation)).to include 'Value invalid, Debt sum must be greater then 0' }
      end
    end
  end
end