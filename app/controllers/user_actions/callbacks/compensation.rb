module UserActions
  module Callbacks
    module Compensation
      def compensation_callback_query(opponent_id = nil, *)
        operation = Debt::Operation::Compensation.call(current_user: current_user, params: { opponent_id: opponent_id })
        if operation.success?
          respond_with :message, success_response(operation)
          bot.send_message success_response(operation).merge(chat_id: opponent_id)
        else
          respond_with :message, failure_response(operation)[:message2]
          bot.send_message failure_response(operation)[:message1].merge(chat_id: operation[:opponent].chat_id)
        end
      end

      def success_response(operation)
        sum = operation[:compensation].format
        u1 = current_user.tag
        u2 = operation[:opponent].tag
        { text: t('telegram_webhooks.compensation_callback_query.success', u1: u1, u2: u2, sum: sum) }
      end

      def failure_response(operation)
        u1 = current_user.tag
        u2 = operation[:opponent].tag
        {
          message1: { text: t('telegram_webhooks.compensation_callback_query.failure1', u1: u1) },
          message2: { text: t('telegram_webhooks.compensation_callback_query.failure2', u1: u1, u2: u2) }
        }
      end
    end
  end
end

