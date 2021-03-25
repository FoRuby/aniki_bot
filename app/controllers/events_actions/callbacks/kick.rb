module EventsActions
  module Callbacks
    module Kick
      def kick_callback_query(user_id = nil, *)
        operation = UserEvent::Operation::Delete.call(current_user: current_user,
                                                      params: { event_id: session[:event_id], user_id: user_id })
        if operation.success?
          answer_callback_query(t('telegram_webhooks.kick_callback_query.success', value: operation[:model].user.tag), show_alert: true)
          u = update.deep_symbolize_keys
          bot.delete_message chat_id: u.dig(:callback_query, :message, :chat, :id),
                             message_id: u.dig(:callback_query, :message, :message_id)
          show = Render::Operation::ShowEvent.call(current_user: current_user, event: operation[:model].event)[:response]
          edit = Render::Operation::EditEvent.call(current_user: current_user, event: operation[:model].event)[:response]
          bot.edit_message_text edit.merge(chat_id: session[:edit_event].dig(:callback_query, :message, :chat, :id),
                                           message_id: session[:edit_event].dig(:callback_query, :message, :message_id))
          bot.edit_message_text show.merge(chat_id: session[:show_event].dig(:callback_query, :message, :chat, :id),
                                           message_id: session[:show_event].dig(:callback_query, :message, :message_id))
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end
    end
  end
end