module EventsActions
  module Callbacks
    module Close
      def close_callback_query(event_id = nil, *)
        operation = Event::Operation::Close.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          reply_with :message, text: t('telegram_webhooks.close_callback_query.success'), parse_mode: 'html'
          bot.unpin_chat_message(chat_id: session[:update].dig(:callback_query, :message, :chat, :id), message_id: session[:update].dig(:result, :message_id))
          bot.send_message(chat_id: session[:update].dig(:callback_query, :message, :chat, :id), text: t('telegram_webhooks.close_callback_query.success'))
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end
    end
  end
end