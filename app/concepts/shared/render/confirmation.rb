module Shared::Render
  class Confirmation < Shared::Render::Base
    attr_reader :positive_callback, :negative_callback, :text

    def initialize(positive_callback: {}, negative_callback: {}, text: "Are you sure?:\n", **args)
      super(**args)
      @positive_callback = { text: 'Yes', callback_data: 'positive_confirmation:' }.merge(positive_callback)
      @negative_callback = { text: 'No', callback_data: 'negative_confirmation:' }.merge(negative_callback)
      @text = text
    end

    def render
      { text: text, chat_id: current_user.chat_id, parse_mode: 'html', reply_markup: reply_markup }
    end

    def reply_markup
      {
        inline_keyboard: [
          [positive_callback, negative_callback]
        ]
      }
    end
  end
end