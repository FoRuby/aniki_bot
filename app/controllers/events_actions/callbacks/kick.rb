module EventsActions
  module Callbacks
    module Kick
      def kick_callback_query(user_id = nil, *)
        operation = UserEvent::Operation::Delete.call(current_user: current_user,
                                                      params: { event_id: session[:event_id], user_id: user_id })
        if operation.success?
          response = Render::Operation::EditEvent.call(current_user: current_user, event: operation[:model].event)[:response]
          edit_message :text, response
          answer_callback_query(t('telegram_webhooks.kick_callback_query.success', value: operation[:model].user.tag), show_alert: true)
          show = Render::Operation::ShowEvent.call(event: operation[:model].event)[:response]
          bot.edit_message_text(show.merge(chat_id: session[:update].dig(:callback_query, :message, :chat, :id), message_id: session[:update].dig(:callback_query, :message, :message_id)))
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end
    end
  end
end