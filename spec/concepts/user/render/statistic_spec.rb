require 'rails_helper'

describe User::Render::Statistic do
  before_all do
    @user = create :user, username: 'foo'
    @user2 = create :user, username: 'bar'
    @event = create :event
    create :user_event, event: @event, user: @user, payment: 100
    @debt1 = create :debt, creditor: @user, borrower: @user2, value: 100
    @debt2 = create :debt, borrower: @user, creditor: @user2, value: 150
  end

  let(:user) { @user }
  let(:user1) { @user1 }
  let(:debt1) { @debt1 }
  let(:debt2) { @debt2 }

  let(:text) do
    "Statistic:\n" \
    "Total spend | 100.00 ₽\n" \
    "Total events | 1\n" \
    "Total borrowed | 100.00 ₽\n" \
    "Top borrower | @bar\n" \
    "Total credited | 150.00 ₽\n" \
    'Top creditor | @bar'
  end

  let(:render) { { text: text, chat_id: user.chat_id } }

  subject { described_class.new(current_user: user) }

  it_behaves_like 'render'
  it_behaves_like 'text'
end
