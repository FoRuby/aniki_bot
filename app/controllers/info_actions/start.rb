module InfoActions
  module Start
    def start!(*)
      respond_with :message, text: t('telegram_webhooks.start.content')
    end
  end
end