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
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end

      def pay(*args)
        return unless current_user.chat_id == payload['chat']['id']

        operation = UserEvent::Operation::Update.call(
          current_user: current_user,
          params: { user_id: current_user.id, event_id: session[:event_id], payment: args.first.to_f }
        )
        if operation.success?
          Event::Response::Pay::Success.call(current_user, operation, payload, session_payload: session[:show_event])
        else
          Shared::Response::Failure.call(current_user, operation, payload)
        end
      end
    end
  end
end