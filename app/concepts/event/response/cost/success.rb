module Event::Response::Cost
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message chat_id: current_user.chat_id, text: I18n.t('telegram_webhooks.cost.success')
    end
  end
end
