module Shared::Operation::Response
  class Failure
    attr_reader :payload, :current_user, :operation, :bot, :callback, :errors

    def initialize(current_user, operation, payload, errors: [], callback: false)
      @current_user = current_user
      @operation = operation
      @payload = payload.deep_symbolize_keys
      @errors = errors
      @callback = callback
      @bot = ANIKI
    end

    def self.call(...)
      new(...).failure_respond
    end

    def failure_respond
      if callback
        bot.answer_callback_query callback_query_id: payload[:id], text: errors_msg, show_alert: true
      else
        bot.send_message chat_id: current_user.chat_id, text: errors_msg
      end
    end

    def errors_msg(form_name: 'default', policy_name: 'default')
      @errors += operation[:errors] if operation[:errors]
      if operation.failure? && operation[:"contract.#{form_name}"]
        errors << operation[:"contract.#{form_name}"].errors.full_messages
      end
      errors << I18n.t('errors.not_found') if operation.failure? && operation[:model].nil?
      errors << I18n.t('errors.unauthorized') if operation[:"result.policy.#{policy_name}"]&.failure?
      errors.join("\n")
    end
  end
end