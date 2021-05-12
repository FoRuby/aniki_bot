require 'rails_helper'

describe Event::Render::KickSelect do
  before_all do
    @admin = create :user
    @user1 = create :user
    @user2 = create :user
    @event = create :event, :with_admin, user: @admin
    @user_event1 = create :user_event, event: @event, user: @user1
    @user_event2 = create :user_event, event: @event, user: @user2
  end
  let(:event) { @event }
  let(:admin) { @admin }
  let(:user1) { @user1 }
  let(:user2) { @user2 }
  let(:user_event1) { @user_event1 }
  let(:user_event2) { @user_event2 }

  let(:text) { 'Select a User to kick out' }
  let(:inline_keyboard) do
    [
      [{ text: user1.tag, callback_data: "kick_event:#{user1.id}" }],
      [{ text: user2.tag, callback_data: "kick_event:#{user2.id}" }]
    ]
  end
  let(:render) { { text: text, parse_mode: 'html', reply_markup: { inline_keyboard: inline_keyboard } } }

  subject { described_class.new(event: event, current_user: admin) }

  it_behaves_like 'render'
  it_behaves_like 'text'
  it_behaves_like 'reply_markup'
end