module EventsActions
  module Callbacks
    module Cost
      def cost_callback_query(event_id = nil, *)
        operation = UserEvent::Operation::Edit.call(
          current_user: current_user,
          params: { user_id: current_user.id, event_id: event_id }
        )
        if operation.success?
          save_context :cost
          session[:event_id] = event_id.to_i
          bot.send_message chat_id: current_user.chat_id, text: t('telegram_webhooks.cost_callback_query.success')
        else
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end

      def cost(*args)
        return unless current_user.chat_id == payload['chat']['id']

        operation = UserEvent::Operation::Update.call(
          current_user: current_user,
          params: { user_id: current_user.id, event_id: session[:event_id], cost: args.first.to_f }
        )
        if operation.success?
          Event::Response::Cost::Success.call(current_user, operation, payload)
        else
          Shared::Response::Failure.call(current_user, operation, payload)
        end
      end
    end
  end
end