module EventsActions
  module Callbacks
    module Kick
      def kick_callback_query(user_id = nil, *)
        operation = UserEvent::Operation::Delete.call(current_user: current_user,
                                                      params: { event_id: session[:event_id], user_id: user_id })
        if operation.success?
          Event::Operation::Response::Kick::Success.call(
            payload: payload, current_user: current_user, operation: operation,
            session_payload: { edit_event: session[:edit_event], show_event: session[:show_event] }
          )
        else
          Shared::Operation::Response::Failure.call(payload: payload, current_user: current_user, operation: operation, callback: true)
        end
      end
    end
  end
end