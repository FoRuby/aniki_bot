module EventsActions
  module Callbacks
    module Join
      def join_callback_query(event_id = nil, *)
        operation = UserEvent::Operation::Create.call(
          current_user: current_user, params: { event_id: event_id, user_id: current_user.id }
        )
        if operation.success?
          Event::Operation::Response::Join::Success.call(payload: payload, current_user: current_user, operation: operation)
        else
          Shared::Operation::Response::Failure.call(payload: payload, current_user: current_user, operation: operation, callback: true)
        end
      end
    end
  end
end