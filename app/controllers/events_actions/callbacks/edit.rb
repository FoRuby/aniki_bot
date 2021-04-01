module EventsActions
  module Callbacks
    module Edit
      def edit_event_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          session[:show_event] = payload.deep_symbolize_keys
          Event::Operation::Response::Edit::Success.call(payload: payload, current_user: current_user, operation: operation)
        else
          Event::Operation::Response::Edit::Failure.call(payload: payload, current_user: current_user, operation: operation)
        end
      end
    end
  end
end