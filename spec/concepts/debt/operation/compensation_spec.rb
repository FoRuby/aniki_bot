require 'rails_helper'

RSpec.describe Debt::Operation::Compensation do
  describe '.call' do
    let(:user1) { create :user }
    let(:user2) { create :user }

    subject(:operation) { described_class.call(params: params, current_user: user) }

    describe 'valid params' do
      let!(:debt1) { create :debt, creditor: user1, borrower: user2, value: 300 }
      let!(:debt2) { create :debt, :with_compensation_flag, creditor: user2, borrower: user1, value: 150 }

      let(:user) { user1 }
      let(:params) { { opponent_id: user2.id } }

      it { should be_success }
      it { expect { operation }.to change(Refill, :count).by(2) }
      it { expect(operation[:debt1].reload.value.format).to eq '150.00 ₽' }
      it { expect(operation[:debt2].reload.value.format).to eq '0.00 ₽' }
    end

    describe 'invalid params' do
      describe 'opponent debt without compensation flag' do
        let!(:debt1) { create :debt, creditor: user1, borrower: user2, value: 300 }
        let!(:debt2) { create :debt, creditor: user2, borrower: user1, value: 150 }

        let(:user) { user1 }
        let(:params) { { opponent_id: user2.id } }

        it { should be_failure }
        it { expect { operation }.to_not change(Refill, :count) }
      end
    end
  end
end
