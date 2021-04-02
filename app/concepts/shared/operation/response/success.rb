module Shared::Operation::Response
  class Success
    attr_reader :payload, :current_user, :operation, :bot, :chat_id, :message_id, :session_payload, :errors

    def initialize(payload:, current_user:, operation:, session_payload: nil, errors: [])
      @current_user = current_user
      @operation = operation
      @payload = payload.deep_symbolize_keys
      @chat_id = @payload.dig(:chat, :id) || @payload.dig(:message, :chat, :id)
      @message_id = @payload[:message_id] || @payload.dig(:message, :message_id)
      @errors = errors
      @session_payload = session_payload
      @bot = ANIKI
    end

    def self.call(...)
      new(...).success_respond
    end

    def success_respond; end
  end
end