module Shared
  class ApplicationResponse
    attr_reader :payload, :current_user, :operation, :bot, :chat_id, :message_id, :errors

    def initialize(payload:, current_user:, operation:)
      @current_user = current_user
      @operation = operation
      @payload = payload.deep_symbolize_keys
      @chat_id = @payload.dig(:chat, :id)
      @message_id = @payload[:message_id]
      @errors = []
      @bot = ANIKI
    end

    def self.call(...)
      new(...).success_respond
    end

    def success_respond; end

    def failure_respond
      bot.send_message chat_id: current_user.chat_id, text: errors_msg
    end

    def errors_msg(form_name: 'default', policy_name: 'default')
      @errors += operation[:errors] if operation[:errors]
      if operation.failure? && operation[:"contract.#{form_name}"]
        errors << operation[:"contract.#{form_name}"].errors.full_messages
      end
      errors << t('errors.not_found') if operation.failure? && operation[:model].nil?
      errors << t('errors.unauthorized') if operation[:"result.policy.#{policy_name}"]&.failure?
      errors.join("\n")
    end
  end
end