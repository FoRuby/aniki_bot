module EventsActions
  module Callbacks
    module Close
      def close_callback_query(event_id = nil, *)
        operation = Event::Operation::Close.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          Event::Operation::Response::Close::Success.call(payload: payload, session_payload: session[:show_event],
                                                          current_user: current_user, operation: operation)
        else
          Shared::Operation::Response::Failure.call(payload: payload, current_user: current_user, operation: operation, callback: true)
        end
      end
    end
  end
end