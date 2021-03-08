module EventsActions
  module Callbacks
    module Join
      def join_callback_query(event_id = nil, *)
        operation = UserEvent::Operation::Create.call(
          current_user: current_user, params: { event_id: event_id, user_id: current_user.id }
        )
        if operation.success?
          response = Render::Operation::ShowEvent.call(event: operation[:model].event)[:response]
          edit_message :text, response
          answer_callback_query(t('telegram_webhooks.join_callback_query.success'), show_alert: true)
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end
    end
  end
end