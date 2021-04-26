module UserActions
  module Callbacks
    module Refill
      def refill_callback_query(debt_id = nil, *)
        session[:debt_id] = debt_id.to_i
        save_context :refill
        respond_with :message, text: t('telegram_webhooks.refill_borrower_callback_query.success')
      end

      def refill(*args)
        return unless current_user.chat_id == payload['chat']['id']

        params = ::Refill::Parser::Create.call(args).merge(debt_id: session[:debt_id])
        operation = ::Refill::Operation::Create.call(params: params)
        if operation.success?
          User::Response::Refill::Success.call(current_user, operation, payload)
        else
          Shared::Response::Failure.call(current_user, operation, payload)
        end
      end
    end
  end
end

