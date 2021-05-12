require 'rails_helper'

describe Event::Render::Show do
  before_all do
    @admin = create :user, username: 'foo'
    @user1 = create :user, username: 'bar'
    @user2 = create :user, username: 'baz'
    @event = create :event, :with_admin, user: @admin, name: 'Foobar', date: '2021-11-11 19:00'
    @user_event1 = create :user_event, event: @event, user: @user1, payment: 100
    @user_event2 = create :user_event, event: @event, user: @user2, payment: 300
  end
  let(:event) { @event }
  let(:admin) { @admin }
  let(:user_event1) { @user_event1 }
  let(:user_event2) { @user_event2 }

  let(:text) do
    "Event info:\n" \
      "ID: #{event.id}\n" \
      "Name: Foobar\n" \
      "Date: November 11, 2021 19:00\n" \
      "Users(3): @foo @bar @baz\n" \
      "Bank: 400.00 ₽\n"
  end
  let(:inline_keyboard) do
    [
      [
        { text: 'Join', callback_data: "join_event:#{event.id}" },
        { text: 'Leave', callback_data: "leave_event:#{event.id}" }
      ],
      [
        { text: 'Info', callback_data: "info_event:#{event.id}" },
        { text: 'Edit', callback_data: "edit_event:#{event.id}" }
      ],
      [{ text: 'Pay', callback_data: "pay_event:#{event.id}" }],
      [{ text: 'Close', callback_data: "close_event_confirmation:#{event.id}" }]
    ]
  end
  let(:render) { { text: text, parse_mode: 'html', reply_markup: { inline_keyboard: inline_keyboard } } }

  subject { described_class.new(event: event, current_user: admin) }

  it_behaves_like 'render'
  it_behaves_like 'text'
  it_behaves_like 'reply_markup'
end