module Event::Operation::Response::Join
  class Success < Shared::ApplicationResponse
    def success_respond
      bot.edit_message_text render.merge(chat_id: chat_id, message_id: message_id)
      bot.answer_callback_query callback_query_id: payload[:id],
                                text: I18n.t('telegram_webhooks.join_callback_query.success'),
                                show_alert: true
    end

    def render
      Event::Operation::Render::Show.call(event: operation[:model].event, current_user: current_user)
    end
  end
end