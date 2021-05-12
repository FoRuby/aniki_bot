require 'rails_helper'

RSpec.describe Debt::Operation::Compensation do
  describe '.call' do
    before_all do
      @user1 = create :user
      @user2 = create :user
      @debt1 = create :debt, creditor: @user1, borrower: @user2, value: 300
      @debt2 = create :debt, :with_compensation_flag, creditor: @user2, borrower: @user1, value: 150
    end
    let(:user1) { @user1 }
    let(:user2) { @user2 }
    let(:debt1) { @debt1 }
    let(:debt2) { @debt2 }

    subject(:operation) { described_class.call(params: params, current_user: user) }

    describe 'valid params' do
      let(:user) { user1 }
      let(:params) { { opponent_id: user2.id } }

      it { should be_success }
      it { expect { operation }.to change(Refill, :count).by(2) }
      it 'should assign attributes' do
        expect(operation[:debt1].value.format).to eq '150.00 ₽'
        expect(operation[:refill1].value.format).to eq '-150.00 ₽'
        expect(operation[:debt1].is_compensation).to be_falsey
        expect(operation[:debt2].value.format).to eq '0.00 ₽'
        expect(operation[:refill2].value.format).to eq '-150.00 ₽'
        expect(operation[:debt2].is_compensation).to be_falsey
      end
    end

    describe 'invalid params' do
      describe 'opponent debt without compensation flag' do
        before_all do
          @user1 = create :user
          @user2 = create :user
          @debt1 = create :debt, creditor: @user1, borrower: @user2, value: 300
          @debt2 = create :debt, creditor: @user2, borrower: @user1, value: 150
        end
        let(:user) { user1 }
        let(:params) { { opponent_id: user2.id } }

        it { should be_failure }
        it { expect { operation }.to_not change(Refill, :count) }
        it 'should assign attributes' do
          expect(operation[:debt1].value.format).to eq '300.00 ₽'
          expect(operation[:debt1].is_compensation).to be_truthy
          expect(operation[:debt2].value.format).to eq '150.00 ₽'
          expect(operation[:debt2].is_compensation).to be_falsey
        end
      end
    end
  end
end
