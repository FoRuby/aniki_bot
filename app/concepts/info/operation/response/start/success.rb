module Info::Operation::Response::Start
  class Success < Shared::Operation::Response::Success
    def success_respond
      bot.send_message text: I18n.t('telegram_webhooks.start.content'), chat_id: chat_id
    end
  end
end
