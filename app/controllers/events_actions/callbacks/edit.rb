module EventsActions
  module Callbacks
    module Edit
      def edit_event_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          session[:show_event] = payload.deep_symbolize_keys
          bot.send_message Render::Operation::EditEvent.call(current_user: current_user, event: operation[:model])[:response]
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end
    end
  end
end