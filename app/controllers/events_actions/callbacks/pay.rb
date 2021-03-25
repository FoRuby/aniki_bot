module EventsActions
  module Callbacks
    module Pay
      def pay_callback_query(event_id = nil, *)
        operation = UserEvent::Operation::Edit.call(
          current_user: current_user,
          params: { user_id: current_user.id, event_id: event_id }
        )
        if operation.success?
          save_context :pay
          session[:event_id] = event_id.to_i
          session[:show_event] = update.deep_symbolize_keys
          bot.send_message chat_id: current_user.chat_id, text: t('telegram_webhooks.pay_callback_query.success')
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end

      def pay(*args)
        return unless current_user.chat_id == payload['chat']['id']

        operation = UserEvent::Operation::Update.call(
          current_user: current_user,
          params: { user_id: current_user.id, event_id: session[:event_id], payment: args.first.to_f }
        )
        if operation.success?
          bot.send_message chat_id: current_user.chat_id, text: t('telegram_webhooks.pay.success')
          show = Render::Operation::ShowEvent.call(event: operation[:model].event)[:response]
          bot.edit_message_text show.merge(chat_id: session[:show_event].dig(:callback_query, :message, :chat, :id),
                                           message_id: session[:show_event].dig(:callback_query, :message, :message_id))
        else
          bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
        end
      end
    end
  end
end