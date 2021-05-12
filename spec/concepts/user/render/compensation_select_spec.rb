require 'rails_helper'

describe User::Render::CompensationSelect do
  before_all do
    @user = create :user, username: 'foo'
    @user2 = create :user, username: 'bar'
    @user3 = create :user, username: 'baz'
    create :debt, creditor: @user, borrower: @user2, value: 100
    create :debt, creditor: @user, borrower: @user3, value: 100
    create :debt, borrower: @user, creditor: @user2, value: 150
  end

  let(:user) { @user }
  let(:user1) { @user1 }
  let(:user2) { @user2 }
  let(:user3) { @user3 }

  let(:text) { 'Select user for Compensation:' }
  let(:inline_keyboard) { [[{ text: '@bar', callback_data: "compensation:#{user2.id}" }]] }
  let(:render) do
    { text: text, parse_mode: 'html', reply_markup: { inline_keyboard: inline_keyboard } }
  end

  subject { described_class.new(current_user: user) }

  it_behaves_like 'render'
  it_behaves_like 'text'
  it_behaves_like 'reply_markup'

  describe '#compensation_users' do
    describe 'present' do
      it { expect(subject.compensation_users).to eq [user2] }
    end

    describe 'present only creditor' do
      let(:user) { user3 }
      it { expect(subject.compensation_users).to be_empty }
    end

    describe 'empty' do
      let(:user) { create :user }
      it { expect(subject.compensation_users).to be_empty }
    end
  end
end
