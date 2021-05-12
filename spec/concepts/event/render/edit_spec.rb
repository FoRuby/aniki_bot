require 'rails_helper'

describe Event::Render::Edit do
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
      [{ text: 'Close', callback_data: "close_event:#{event.id}" }],
      [{ text: 'Update', callback_data: "update_event:#{event.id}" }],
      [{ text: 'Add Admin', callback_data: "add_event_admin_select:#{event.id}" }],
      [{ text: "Add Description", callback_data: "description_event:#{event.id}" }],
      [{ text: 'Kick User', callback_data: "kick_event_select:#{event.id}" }]
    ]
  end
  let(:render) do
    { text: text,
      chat_id: admin.chat_id,
      parse_mode: 'html',
      reply_markup: { inline_keyboard: inline_keyboard } }
  end

  subject { described_class.new(event: event, current_user: admin) }

  it_behaves_like 'render'
  it_behaves_like 'text'
  it_behaves_like 'reply_markup'

  describe '#description_action' do
    describe 'event with description' do
      let(:event) { build :event, description: 'Description' }
      it { expect(subject.description_action).to eq 'Change' }
    end

    describe 'event without description' do
      let(:event) { build :event }
      it { expect(subject.description_action).to eq 'Add' }
    end
  end
end