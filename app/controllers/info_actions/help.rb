module InfoActions
  module Help
    def help!(*)
      respond_with :message, text: t('telegram_webhooks.start.content')
    end
  end
end