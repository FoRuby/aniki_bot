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
          session[:show_event] = payload.deep_symbolize_keys
          bot.send_message chat_id: current_user.chat_id, text: t('telegram_webhooks.pay_callback_query.success')
        else
          Event::Operation::Response::Edit::Failure.call(payload: payload, current_user: current_user, operation: operation)
        end
      end

      def pay(*args)
        return unless current_user.chat_id == payload['chat']['id']

        operation = UserEvent::Operation::Update.call(
          current_user: current_user,
          params: { user_id: current_user.id, event_id: session[:event_id], payment: args.first.to_f }
        )
        if operation.success?
          Event::Operation::Response::Pay::Success.call(payload: payload, session_payload: session[:show_event],
                                                        current_user: current_user, operation: operation)
        else
          Event::Operation::Response::Pay::Failure.call(payload: payload, current_user: current_user, operation: operation)
        end
      end
    end
  end
end