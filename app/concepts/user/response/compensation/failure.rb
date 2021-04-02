module User::Response::Compensation
  class Failure < Shared::Response::Failure
    def failure_respond
      bot.send_message text: user_message, chat_id: current_user.chat_id
      bot.send_message text: opponent_message, chat_id: operation[:opponent].chat_id
    end

    def opponent_message
      I18n.t('telegram_webhooks.compensation_callback_query.opponent_message', user: current_user.tag)
    end

    def user_message
      I18n.t('telegram_webhooks.compensation_callback_query.user_message', opponent: operation[:opponent].tag)
    end
  end
end
