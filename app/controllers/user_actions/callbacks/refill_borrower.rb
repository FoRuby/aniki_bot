module UserActions
  module Callbacks
    module RefillBorrower
      def refill_borrower_callback_query(borrower_id = nil, *)
        session[:borrower_id] = borrower_id.to_i
        save_context :refill_borrower
        respond_with :message, text: t('telegram_webhooks.refill_borrower_callback_query.success')
      end

      def refill_borrower(*args)
        return unless current_user.chat_id == payload['chat']['id']

        operation = Debt::Operation::Refill.call(
          current_user: current_user,
          params: { borrower_id: session[:borrower_id], creditor_id: current_user.id, value: args.first.to_f }
        )
        if operation.success?
          User::Response::Refill::Success.call(current_user, operation, payload)
        else
          Shared::Response::Failure.call(current_user, operation, payload)
        end
      end
    end
  end
end

