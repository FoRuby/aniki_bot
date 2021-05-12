require 'rails_helper'

describe User::Render::Me do
  before_all do
    @user = create :user
  end
  let(:user) { @user }

  let(:text) { 'Select option:' }
  let(:inline_keyboard) do
    [
      [{ text: 'Finance', callback_data: "finance:#{user.id}" }],
      [{ text: 'Statistic', callback_data: "statistic:#{user.id}" }],
      [{ text: 'Refill', callback_data: "refill_select:#{user.id}" }],
      [{ text: 'Compensation', callback_data: "compensation_select:#{user.id}" }]
    ]
  end
  let(:render) { { text: text, chat_id: user.chat_id, parse_mode: 'html', reply_markup: { inline_keyboard: inline_keyboard } } }

  subject { described_class.new(current_user: user) }

  it_behaves_like 'render'
  it_behaves_like 'text'
  it_behaves_like 'reply_markup'
end