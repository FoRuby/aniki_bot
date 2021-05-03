ANIKI = Telegram::Bot::Client.new(Rails.application.credentials.dig(:telegram, :bot, :token))
