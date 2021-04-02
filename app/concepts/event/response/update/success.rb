module Event::Response::Update
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message chat_id: chat_id, text: I18n.t('telegram_webhooks.update_event.success')
      bot.edit_message_text render_edit.merge(chat_id: session_payload[:edit_event].dig(:message, :chat, :id),
                                              message_id: session_payload[:edit_event].dig(:message, :message_id))
      bot.edit_message_text render_show.merge(chat_id: session_payload[:show_event].dig(:message, :chat, :id),
                                              message_id: session_payload[:show_event].dig(:message, :message_id))
    end

    def render_edit
      Event::Render::Edit.call(event: operation[:model], current_user: current_user)
    end

    def render_show
      Event::Render::Show.call(event: operation[:model], current_user: current_user)
    end
  end
end
