module InfoActions
  module Van
    def van!(*)
      respond_with :photo, photo: image('van.jpg'), caption: t('telegram_webhooks.van.content')
    end
  end
end