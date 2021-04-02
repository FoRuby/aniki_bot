module EventsActions
  module Callbacks
    module Update
      def update_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          session[:event_id] = operation[:model].id
          session[:edit_event] = payload.deep_symbolize_keys
          save_context :update_event
          bot.send_message chat_id: current_user.chat_id, text: t('telegram_webhooks.update_callback_query.success'), alert: true
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end

      def update_event(*args)
        return unless current_user.chat_id == payload['chat']['id']

        params = Event::Parser::Base.call(args).merge(id: session[:event_id])
        operation = Event::Operation::Update.call(current_user: current_user, params: params)
        if operation.success?
          respond_with :message, text: t('telegram_webhooks.update_event.success')
          show = Render::Operation::ShowEvent.call(current_user: current_user, event: operation[:model])[:response]
          edit = Render::Operation::EditEvent.call(current_user: current_user, event: operation[:model])[:response]
          bot.edit_message_text edit.merge(chat_id: session[:edit_event].dig(:callback_query, :message, :chat, :id),
                                           message_id: session[:edit_event].dig(:callback_query, :message, :message_id))
          bot.edit_message_text show.merge(chat_id: session[:show_event].dig(:callback_query, :message, :chat, :id),
                                           message_id: session[:show_event].dig(:callback_query, :message, :message_id))
        else
          bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
        end
      end
    end
  end
end