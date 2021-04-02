module Info::Operation::Response::Van
  class Success < Shared::Operation::Response::Success
    def success_respond
      bot.send_photo photo: image('van.jpg'), chat_id: chat_id, caption: I18n.t('telegram_webhooks.van.content')
    end
  end
end
