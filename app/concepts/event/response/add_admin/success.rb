module Event::Response::AddAdmin
  class Success < Shared::Response::Success
    def success_respond
      bot.answer_callback_query callback_query_id: payload[:id],
                                text: I18n.t('telegram_webhooks.add_admin_callback_query.success', value: operation[:model].user.tag),
                                show_alert: true
      bot.delete_message chat_id: chat_id, message_id: message_id
    end
  end
end
