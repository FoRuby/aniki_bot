module Feedback::Operation::Response::Create
  class Success < Shared::ApplicationResponse
    def success_respond
      bot.send_message chat_id: chat_id, text: I18n.t('telegram_webhooks.feedback.success')
    end
  end
end
