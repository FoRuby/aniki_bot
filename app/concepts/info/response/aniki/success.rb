module Info::Response::Aniki
  class Success < Shared::Response::Success
    def success_respond
      bot.send_photo photo: image('aniki.jpg'), chat_id: chat_id, caption: I18n.t('telegram_webhooks.aniki.content')
    end
  end
end
