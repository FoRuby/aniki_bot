module Event::Response::Create
  class Success < Event::Response::Show::Success
    def success_respond
      message = bot.send_message(render.merge(chat_id: chat_id)).deep_symbolize_keys
      bot.pin_chat_message chat_id: message.dig(:result, :chat, :id),
                           message_id: message.dig(:result, :message_id)
    end
  end
end
