module Event::Operation::Response::Create
  class Success < Shared::Operation::Response::Success
    def success_respond
      respond_msg
      return if respond_msg.dig(:result, :chat, :type) != 'supergroup'

      bot.pin_chat_message(chat_id: respond_msg.dig(:result, :chat, :id),
                           message_id: respond_msg.dig(:result, :message_id))
    end

    def respond_msg
      @respond_msg ||= bot.send_message(render.merge(chat_id: chat_id)).deep_symbolize_keys
    end

    def render
      Event::Operation::Render::Show.call(event: operation[:model], current_user: current_user)
    end
  end
end
