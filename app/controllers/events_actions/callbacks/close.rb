module EventsActions
  module Callbacks
    module Close
      def close_callback_query(event_id = nil, *)
        operation = Event::Operation::Close.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          Event::Operation::Response::Close::Success.call(current_user, operation, payload, session_payload: session[:show_event])
        else
          Shared::Operation::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end
    end
  end
end