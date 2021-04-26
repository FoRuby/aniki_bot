module EventsActions
  module Callbacks
    module AddAdmin
      def add_event_admin_callback_query(user_id = nil, *)
        operation = UserEvent::Operation::AddAdmin.call(current_user: current_user,
                                                        params: { event_id: session[:event_id], user_id: user_id })
        if operation.success?
          Event::Response::AddAdmin::Success.call(current_user, operation, payload)
        else
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end
    end
  end
end