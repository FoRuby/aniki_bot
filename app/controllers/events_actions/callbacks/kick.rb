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
          Event::Operation::Response::Kick::Failure.call(payload: payload, current_user: current_user, operation: operation)
        end
      end
    end
  end
end