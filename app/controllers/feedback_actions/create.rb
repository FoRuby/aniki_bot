module FeedbackActions
  module Create
    def feedback!(*args)
      operation = Feedback::Operation::Create.call(current_user: current_user, params: Feedback::Parser::Base.call(args))
      if operation.success?
        respond_with :message, text: t('telegram_webhooks.feedback.success')
      else
        bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
      end
    end
  end
end