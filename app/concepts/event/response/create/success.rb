module Event::Response::Create
  class Success < Event::Response::Show::Success
    attr_reader :message

    def success_respond
      super
      pin_message
    end

    def pin_message
      bot.pin_chat_message chat_id: message.dig(:result, :chat, :id),
                           message_id: message.dig(:result, :message_id)
    end
  end
end
