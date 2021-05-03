module User::Response::Compensation
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message text: message, chat_id: current_user.chat_id
      bot.send_message text: message, chat_id: operation[:opponent].chat_id
    end

    def message
      I18n.t('telegram_webhooks.compensation_callback_query.success',
             user: current_user.tag,
             opponent: operation[:opponent].tag,
             sum: operation[:compensation].abs.format)
    end
  end
end
