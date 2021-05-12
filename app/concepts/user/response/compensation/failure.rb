module User::Response::Compensation
  class Failure < Shared::Response::Failure
    def failure_respond
      bot.send_message text: user_message, chat_id: current_user.chat_id
      bot.send_message opponent_render
    end

    def opponent_render
      Shared::Render::Confirmation.call(
        current_user: operation[:opponent],
        text: I18n.t('telegram_webhooks.compensation_callback_query.opponent_message',
                     user: current_user.tag,
                     sum: operation[:compensation].abs.format),
        positive_callback: { callback_data: "compensation:#{current_user.id}" }
      )
    end

    def user_message
      I18n.t('telegram_webhooks.compensation_callback_query.user_message', opponent: operation[:opponent].tag)
    end
  end
end
