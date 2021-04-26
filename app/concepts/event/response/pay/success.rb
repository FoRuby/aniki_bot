module Event::Response::Pay
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message chat_id: current_user.chat_id, text: I18n.t('telegram_webhooks.pay.success')
      bot.edit_message_text render.merge(chat_id: session_payload.dig(:message, :chat, :id),
                                         message_id: session_payload.dig(:message, :message_id))
    end

    def render
      Event::Render::Show.call(event: model.event, current_user: current_user)
    end
  end
end
