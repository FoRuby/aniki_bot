module Event::Response::Close
  class Success < Shared::Response::Success
    attr_reader :group_message, :private_message

    def success_respond
      send_group_message
      send_private_message if group_message.deep_symbolize_keys.dig(:result, :chat, :type) == 'supergroup'
      unpin_message
      delete_edit_form
    end

    def send_group_message
      @group_message = bot.send_message chat_id: session_payload.dig(:message, :chat, :id), text: message_text
    end

    def send_private_message
      bot.send_message chat_id: chat_id, text: message_text
    end

    def unpin_message
      bot.unpin_chat_message chat_id: session_payload.dig(:message, :chat, :id),
                             message_id: session_payload.dig(:message, :message_id)
    end

    def delete_edit_form
      bot.delete_message chat_id: chat_id, message_id: message_id
    end

    def message_text
      I18n.t('telegram_webhooks.close_callback_query.success', name: model.name)
    end
  end
end
