module EventsActions
  module Callbacks
    module Leave
      def leave_callback_query(event_id = nil, *)
        operation = UserEvent::Operation::Delete.call(
          current_user: current_user, params: { event_id: event_id, user_id: current_user.id }
        )
        if operation.success?
          Event::Operation::Response::Leave::Success.call(payload: payload, current_user: current_user, operation: operation)
        else
          Event::Operation::Response::Leave::Failure.call(payload: payload, current_user: current_user, operation: operation)
        end
      end
    end
  end
end
