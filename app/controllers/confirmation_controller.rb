module ConfirmationController
  def positive_confirmation_callback_query(*)
    bot.answer_callback_query text: 'Confirmed!', show_alert: true
  end

  def negative_confirmation_callback_query(*)
    p = payload.deep_symbolize_keys
    bot.delete_message chat_id: p.dig(:message, :chat, :id), message_id: p.dig(:message, :message_id)
  end
end