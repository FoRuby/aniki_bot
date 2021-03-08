module UserActions
  module Callbacks
    module RefillBorrower
      def refill_borrower_callback_query(borrower_id = nil, *)
        session[:borrower_id] = borrower_id.to_i
        save_context :refill_borrower
        respond_with :message, text: t('telegram_webhooks.refill_borrower_callback_query.success'), alert: true
      end

      def refill_borrower(*args)
        return unless current_user.chat_id == payload['chat']['id']

        operation = Debt::Operation::Refill.call(
          current_user: current_user,
          params: { borrower_id: session[:borrower_id], creditor_id: current_user.id, value: args.first.to_f }
        )
        if operation.success?
          respond_with :message, response(operation)
          bot.send_message response(operation).merge(chat_id: session[:borrower_id])
        else
          respond_with :message, text: render_errors(operation)
        end
      end

      def response(operation)
        form = operation[:"contract.default"]
        refill = form.refills.last.model.value.format
        u1 = form.model.creditor.tag
        u2 = form.model.borrower.tag
        { text: t('telegram_webhooks.refill_borrower.success', u1: u1, u2: u2, refill: refill) }
      end
    end
  end
end

