module EventsActions
  module Callbacks
    module Leave
      def leave_callback_query(event_id = nil, *)
        operation = UserEvent::Operation::Delete.call(
          current_user: current_user, params: { event_id: event_id, user_id: current_user.id }
        )
        if operation.success?
          Event::Response::Leave::Success.call(current_user, operation, payload)
        else
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end
    end
  end
end
