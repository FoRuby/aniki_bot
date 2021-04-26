module Event::Response::Join
  class Success < Shared::Response::Success
    def success_respond
      bot.edit_message_text render.merge(chat_id: chat_id, message_id: message_id)
      bot.answer_callback_query callback_query_id: payload[:id],
                                text: I18n.t('telegram_webhooks.join_callback_query.success'),
                                show_alert: true
    end

    def render
      Event::Render::Show.call(event: model.event, current_user: current_user)
    end
  end
end
