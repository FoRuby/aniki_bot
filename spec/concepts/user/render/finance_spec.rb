require 'rails_helper'

describe User::Render::Finance do
  before_all do
    @user = create :user, username: 'foo'
    @user2 = create :user, username: 'bar'
    @user3 = create :user
    @debt1 = create :debt, creditor: @user, borrower: @user2, value: 100
    @debt2 = create :debt, borrower: @user, creditor: @user2, value: 150
  end

  let(:user) { @user }
  let(:user1) { @user1 }
  let(:user3) { @user3 }
  let(:debt1) { @debt1 }
  let(:debt2) { @debt2 }

  let(:text) do
    "Your Borrowers:\n@bar | 100.00 ₽\n" \
    "Your Creditors:\n@bar | 150.00 ₽\n"
  end

  let(:render) { { text: text, chat_id: user.chat_id } }

  subject { described_class.new(current_user: user) }

  it_behaves_like 'render'
  it_behaves_like 'text'

  describe 'borrowers' do
    describe 'present' do
      it { expect(subject.borrowers).to eq "Your Borrowers:\n@bar | 100.00 ₽\n" }
    end

    describe 'empty' do
      subject { described_class.new(current_user: user3) }

      it { expect(subject.borrowers).to eq "You have not Borrowers\n" }
    end
  end

  describe 'creditors' do
    describe 'present' do
      it { expect(subject.creditors).to eq "Your Creditors:\n@bar | 150.00 ₽\n" }
    end

    describe 'empty' do
      subject { described_class.new(current_user: user3) }

      it { expect(subject.creditors).to eq "You have not Creditors\n" }
    end
  end
end
