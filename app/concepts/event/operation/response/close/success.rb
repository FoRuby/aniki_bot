module Event::Operation::Response::Close
  class Success < Shared::ApplicationResponse
    def success_respond
      bot.send_message chat_id: session_payload.dig(:message, :chat, :id),
                       text: I18n.t('telegram_webhooks.close_callback_query.success')
      bot.send_message chat_id: chat_id,
                       text: I18n.t('telegram_webhooks.close_callback_query.success')
      bot.unpin_chat_message chat_id: session_payload.dig(:message, :chat, :id),
                             message_id: session_payload.dig(:message, :message_id)
    end
  end
end
