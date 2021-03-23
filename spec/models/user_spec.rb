require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:user_events).dependent(:destroy) }
    it { should have_many(:events).through(:user_events) }

    it { should have_many(:user_creditors).class_name(Debt).with_foreign_key(:borrower_id) }
    it { should have_many(:creditors).through(:user_creditors) }
    it { should have_many(:positive_creditors).through(:user_creditors) }

    it { should have_many(:user_borrowers).class_name(Debt).with_foreign_key(:creditor_id) }
    it { should have_many(:borrowers).through(:user_borrowers) }
    it { should have_many(:positive_borrowers).through(:user_borrowers) }

    it { should have_many(:feedbacks).dependent(:destroy) }
  end

  describe 'validations' do
  end

  describe 'delegators' do
  end

  describe 'nested attributes' do
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
    describe '#tag' do
      subject { user.tag }

      describe 'user with username' do
        let(:user) { create :user, username: 'foo' }

        it { should eq '@foo' }
      end

      describe 'user without username' do
        let(:user) { create :user, first_name: 'Alice', username: nil }

        it { should eq 'Alice' }
      end
    end

    describe '#top_borrower' do
      subject { user.top_borrower }
      let(:user) { create :user }

      describe 'many borrowers' do
        let!(:debt1) { create :debt, creditor: user, value: 150 }
        let!(:debt2) { create :debt, creditor: user, value: 250 }

        it { should eq debt2.borrower }
      end

      describe 'nil borrowers' do
        it { should be_nil }
      end
    end

    describe '#top_creditor' do
      subject { user.top_creditor }
      let(:user) { create :user }

      describe 'many creditors' do
        let!(:debt1) { create :debt, borrower: user, value: 150 }
        let!(:debt2) { create :debt, borrower: user, value: 250 }

        it { should eq debt2.creditor }
      end

      describe 'nil creditors' do
        it { should be_nil }
      end
    end

    describe '#total_spend' do
      subject { user.total_spend }
      let(:user) { create :user }

      describe 'many payments' do
        let!(:user_event1) { create :user_event, user: user, payment: 300 }
        let!(:user_event2) { create :user_event, user: user, payment: 200 }

        it { should eq '500.00 ₽' }
      end

      describe 'nil payments' do
        it { should eq '0.00 ₽' }
      end
    end

    describe '#total_borrowed' do
      subject { user.total_borrowed }
      let(:user) { create :user }

      describe 'many borrowers' do
        let!(:borrower1) { create :debt, creditor: user, value: 100 }
        let!(:borrower2) { create :debt, creditor: user, value: 200 }

        it { should eq '300.00 ₽' }
      end

      describe 'nil borrowers' do
        it { should eq '0.00 ₽' }
      end
    end

    describe '#total_credited' do
      subject { user.total_credited }
      let(:user) { create :user }

      describe 'many creditors' do
        let!(:creditor1) { create :debt, borrower: user, value: 150 }
        let!(:creditor2) { create :debt, borrower: user, value: 250 }

        it { should eq '400.00 ₽' }
      end

      describe 'nil creditors' do
        it { should eq '0.00 ₽' }
      end
    end
  end
end