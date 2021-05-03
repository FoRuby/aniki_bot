module Shared::Render
  class Confirmation < Shared::Render::Base
    attr_reader :positive_callback, :negative_callback, :text

    def initialize(positive_callback: nil, negative_callback: nil, text: nil, **args)
      super(**args)
      @positive_callback = positive_callback || 'positive_confirmation:'
      @negative_callback = negative_callback || 'negative_confirmation:'
      @text = text || "Are you sure?:\n"
    end

    def render
      @render ||= { text: text, chat_id: current_user.chat_id, parse_mode: 'html', reply_markup: reply_markup }
    end

    def reply_markup
      {
        inline_keyboard: [
          [
            { text: 'OK', callback_data: positive_callback },
            { text: 'Cancel', callback_data: negative_callback }
          ]
        ]
      }
    end
  end
end