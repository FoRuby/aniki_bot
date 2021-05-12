require 'rails_helper'

describe Shared::Render::Confirmation do
  before_all do
    @user = create :user
  end
  let(:user) { @user }

  describe 'params' do
    let(:text) { "Answer?:\n" }
    let(:inline_keyboard) { [[positive_callback, negative_callback]] }
    let(:render) do
      { text: text,
        chat_id: user.chat_id,
        parse_mode: 'html',
        reply_markup: { inline_keyboard: inline_keyboard } }
    end

    subject do
      described_class.new(
        current_user: user, text: text, positive_callback: positive_callback, negative_callback: negative_callback
      )
    end

    describe 'full' do
      let(:positive_callback) { { text: 'Sure', callback_data: 'positive_callback_data:1' } }
      let(:negative_callback) { { text: 'No way', callback_data: 'negative_callback_data:1' } }

      it_behaves_like 'render'
      it_behaves_like 'text'
      it_behaves_like 'reply_markup'
    end

    describe 'exclude text' do
      let(:inline_keyboard) { [[positive_callback.merge(text: 'Yes'), negative_callback.merge(text: 'No')]] }
      let(:positive_callback) { { callback_data: 'positive_callback_data:1' } }
      let(:negative_callback) { { callback_data: 'negative_callback_data:1' } }

      it_behaves_like 'render'
      it_behaves_like 'text'
      it_behaves_like 'reply_markup'
    end

    describe 'without' do
      subject { described_class.new(current_user: user) }

      let(:text) { "Are you sure?:\n" }
      let(:positive_callback) { { text: 'Yes', callback_data: 'positive_confirmation:' } }
      let(:negative_callback) { { text: 'No', callback_data: 'negative_confirmation:' } }
      let(:inline_keyboard) { [[positive_callback, negative_callback]] }

      it_behaves_like 'render'
      it_behaves_like 'text'
      it_behaves_like 'reply_markup'
    end
  end
end