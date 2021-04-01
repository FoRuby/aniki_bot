module Event::Operation::Response::Create
  class Success < Shared::ApplicationResponse
    def success_respond
      respond_msg
      return if respond_msg.dig(:result, :chat, :type) != 'supergroup'

      bot.pin_chat_message(chat_id: respond_msg.dig(:result, :chat, :id),
                           message_id: respond_msg.dig(:result, :message_id))
    end

    def render
      Render::Operation::ShowEvent.call(event: operation[:model])[:response]
    end

    def respond_msg
      @respond_msg ||= bot.send_message(render.merge(chat_id: chat_id)).deep_symbolize_keys
    end
  end
end
