module User::Response::Refill
  class Success < Shared::Response::Success
    attr_reader :refill

    def initialize(current_user, operation, payload, session_payload: nil)
      super
      @refill = operation[:refill]
    end

    def success_respond
      bot.send_message text: message, chat_id: refill.creditor.chat_id
      bot.send_message text: message, chat_id: refill.borrower.chat_id
    end

    def message
      I18n.t('telegram_webhooks.refill_borrower.success',
             creditor: refill.creditor.tag,
             borrower: refill.borrower.tag,
             refill: refill.value.abs.format)
    end
  end
end
