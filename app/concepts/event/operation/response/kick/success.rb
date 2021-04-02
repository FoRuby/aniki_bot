module Event::Operation::Response::Kick
  class Success < Shared::Operation::Response::Success
    def success_respond
      bot.answer_callback_query callback_query_id: payload[:id],
                                text: I18n.t('telegram_webhooks.kick_callback_query.success', value: operation[:model].user.tag),
                                show_alert: true
      bot.delete_message chat_id: chat_id, message_id: message_id
      bot.edit_message_text render_edit.merge(chat_id: session_payload[:edit_event].dig(:message, :chat, :id),
                                              message_id: session_payload[:edit_event].dig(:message, :message_id))
      bot.edit_message_text render_show.merge(chat_id: session_payload[:show_event].dig(:message, :chat, :id),
                                              message_id: session_payload[:show_event].dig(:message, :message_id))
    end

    def render_edit
      Event::Operation::Render::Edit.call(event: operation[:model].event, current_user: current_user)
    end

    def render_show
      Event::Operation::Render::Show.call(event: operation[:model].event, current_user: current_user)
    end
  end
end
