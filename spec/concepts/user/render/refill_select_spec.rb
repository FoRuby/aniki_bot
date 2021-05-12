require 'rails_helper'

describe User::Render::RefillSelect do
  before_all do
    @user = create :user, username: 'foo'
    @user1 = create :user, username: 'bar'
    @user2 = create :user, username: 'baz'
    @user3 = create :user
    @debt1 = create :debt, creditor: @user, borrower: @user1, value: 100
    @debt2 = create :debt, creditor: @user, borrower: @user2, value: 100
    @debt3 = create :debt, creditor: @user, borrower: @user3, value: 0
  end

  let(:user) { @user }
  let(:user1) { @user1 }
  let(:user2) { @user2 }
  let(:user3) { @user2 }
  let(:debt1) { @debt1 }
  let(:debt2) { @debt2 }
  let(:debt3) { @debt3 }

  let(:text) { 'Select Borrower:' }
  let(:inline_keyboard) do
    [
      [{ text: '@bar', callback_data: "refill:#{debt1.id}" }],
      [{ text: '@baz', callback_data: "refill:#{debt2.id}" }]
    ]
  end
  let(:render) do
    { text: text, parse_mode: 'html', reply_markup: { inline_keyboard: inline_keyboard } }
  end

  subject { described_class.new(current_user: user) }

  it_behaves_like 'render'
  it_behaves_like 'text'
  it_behaves_like 'reply_markup'

  describe '#debts' do
    describe 'present' do
      it { expect(subject.debts).to eq [debt1, debt2] }
    end

    describe 'empty' do
      let(:user) { user2 }
      it { expect(subject.debts).to be_empty }
    end
  end
end
