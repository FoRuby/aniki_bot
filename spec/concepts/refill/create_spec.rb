require 'rails_helper'

RSpec.describe Refill::Operation::Create do
  let(:creditor) { create :user }
  let(:borrower) { create :user }

  describe '.call' do
    subject(:operation) { described_class.call(params: params, current_user: user) }

    describe 'valid params' do
      let!(:debt) { create :debt, borrower: borrower, creditor: creditor, debt: 300 }
      let(:params) { { from_user: borrower, to_user: creditor, value: Money.new(20_000, 'RUB') } }
      let(:user) { borrower }

      it { should be_success }
      it { expect { operation }.to change(Refill, :count).by(1) }
      it { expect(operation[:debt].debt.format).to eq '100.00 ₽' }
    end
  end
end