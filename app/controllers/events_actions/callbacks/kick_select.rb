module EventsActions
  module Callbacks
    module KickSelect
      def kick_select_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          session[:event_id] = event_id.to_i
          session[:edit_event] = payload.deep_symbolize_keys
          Event::Response::KickSelect::Success.call(current_user, operation, payload)
        else
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end
    end
  end
end

