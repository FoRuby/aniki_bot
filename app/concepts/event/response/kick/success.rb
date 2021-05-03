module Event::Response::Kick
  class Success < Shared::Response::Success
    def success_respond
      bot.answer_callback_query callback_query_id: payload[:id],
                                text: I18n.t('telegram_webhooks.kick_callback_query.success', value: model.user.tag),
                                show_alert: true
      bot.delete_message chat_id: chat_id, message_id: message_id
      bot.edit_message_text render_edit.merge(chat_id: session_payload.dig(:edit_event, :message, :chat, :id),
                                              message_id: session_payload.dig(:edit_event, :message, :message_id))
      bot.edit_message_text render_show.merge(chat_id: session_payload.dig(:show_event, :message, :chat, :id),
                                              message_id: session_payload.dig(:show_event, :message, :message_id))
    end

    def render_edit
      Event::Render::Edit.call(event: model.event, current_user: current_user)
    end

    def render_show
      Event::Render::Show.call(event: model.event, current_user: current_user)
    end
  end
end
