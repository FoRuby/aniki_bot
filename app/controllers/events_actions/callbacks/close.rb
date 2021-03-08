module EventsActions
  module Callbacks
    module Close
      def close_callback_query(event_id = nil, *)
        operation = Event::Operation::Close.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          reply_with :message, text: t('telegram_webhooks.close_callback_query.success'), parse_mode: 'html'
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end
    end
  end
end