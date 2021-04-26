module EventsActions
  module Callbacks
    module AddAdminSelect
      def add_event_admin_select_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          session[:event_id] = event_id.to_i
          Event::Response::AddAdminSelect::Success.call(current_user, operation, payload)
        else
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end
    end
  end
end

