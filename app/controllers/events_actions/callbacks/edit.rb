module EventsActions
  module Callbacks
    module Edit
      def edit_event_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          session[:show_event] = payload.deep_symbolize_keys
          Event::Operation::Response::Edit::Success.call(current_user, operation, payload)
        else
          Shared::Operation::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end
    end
  end
end