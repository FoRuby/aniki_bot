module EventsActions
  module Callbacks
    module Join
      def join_event_callback_query(event_id = nil, *)
        operation = UserEvent::Operation::Create.call(
          current_user: current_user, params: { event_id: event_id, user_id: current_user.id }
        )
        if operation.success?
          Event::Response::Join::Success.call(current_user, operation, payload)
        else
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end
    end
  end
end