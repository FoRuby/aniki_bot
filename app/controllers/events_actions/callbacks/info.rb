module EventsActions
  module Callbacks
    module Info
      def info_event_callback_query(event_id = nil, *)
        operation = Event::Operation::Show.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          Event::Response::Info::Success.call(current_user, operation, payload)
        else
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end
    end
  end
end