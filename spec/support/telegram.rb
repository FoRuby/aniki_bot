RSpec.configure do |config|
  config.after { Telegram.bot.reset }
  config.after { Telegram.bots.each_value(&:reset) }
end