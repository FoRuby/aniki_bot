module Info::Response::Start
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message text: I18n.t('telegram_webhooks.start.content'), chat_id: chat_id
    end
  end
end
