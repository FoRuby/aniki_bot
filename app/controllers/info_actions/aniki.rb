module InfoActions
  module Aniki
    def aniki!(*)
      respond_with :photo, photo: image('aniki.jpg'), caption: t('telegram_webhooks.aniki.content')
    end
  end
end