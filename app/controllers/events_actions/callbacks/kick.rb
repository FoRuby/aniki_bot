module EventsActions
  module Callbacks
    module Kick
      def kick_event_callback_query(user_id = nil, *)
        operation = UserEvent::Operation::Delete.call(current_user: current_user,
                                                      params: { event_id: session[:event_id], user_id: user_id })
        if operation.success?
          Event::Response::Kick::Success.call(
            current_user, operation, payload,
            session_payload: { edit_event: session[:edit_event], show_event: session[:show_event] }
          )
        else
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end
    end
  end
end