module EventsActions
  module Callbacks
    module KickSelect
      def kick_select_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          session[:event_id] = event_id.to_i
          session[:edit_event] = payload.deep_symbolize_keys
          Event::Operation::Response::KickSelect::Success.call(payload: payload, current_user: current_user, operation: operation)
        else
          Event::Operation::Response::KickSelect::Failure.call(payload: payload, current_user: current_user, operation: operation)
        end
      end
    end
  end
end

