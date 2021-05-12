require 'rails_helper'

describe Event::Render::Info do
  before_all do
    @admin = create :user, username: 'foo'
    @user1 = create :user, username: 'bar'
    @user2 = create :user, username: 'baz'
    @event = create :event, :with_admin, user: @admin, name: 'Foobar', date: '2021-11-11 19:00'
    @user_event1 = create :user_event, event: @event, user: @user1, payment: 100
    @user_event2 = create :user_event, event: @event, user: @user2, payment: 200
  end
  let(:event) { @event }
  let(:admin) { @admin }
  let(:user_event1) { @user_event1 }
  let(:user_event2) { @user_event2 }

  let(:payments) do
    "Payments:\n" \
    "@foo | 0.00 ₽ (100.00 ₽)\n" \
    "@bar | 100.00 ₽ (100.00 ₽)\n" \
    '@baz | 200.00 ₽ (100.00 ₽)'
  end
  let(:text) do
    "Event info:\n" \
    "ID: #{event.id}\n" \
    "Name: Foobar\n" \
    "Status: open\n" \
    "Date: November 11, 2021 19:00\n" \
    "Admins(1): @foo\n" \
    "Users(3): @foo @bar @baz\n" \
    "Bank: 300.00 ₽\n".concat(payments)
  end
  let(:render) { { text: text, chat_id: admin.chat_id } }

  subject { described_class.new(event: event, current_user: admin) }

  it_behaves_like 'render'
  it_behaves_like 'text'

  describe '#description' do
    describe 'event with description' do
      let(:event) { build :event, description: 'Description' }
      it { expect(subject.description).to eq "Description: Description\n" }
    end

    describe 'event without description' do
      let(:event) { build :event }
      it { expect(subject.description).to eq '' }
    end
  end

  describe '#payments' do
    describe 'event with users' do
      it { expect(subject.payments).to eq payments }
    end

    describe 'event without users' do
      let(:event) { create :event }
      it { expect(subject.payments).to eq 'There are no users in the event' }
    end
  end
end