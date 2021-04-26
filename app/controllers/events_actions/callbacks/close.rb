module EventsActions
  module Callbacks
    module Close
      def close_event_callback_query(event_id = nil, *)
        operation = Event::Operation::Close.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          Event::Response::Close::Success.call(current_user, operation, payload, session_payload: session[:show_event])
        else
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end
    end
  end
end