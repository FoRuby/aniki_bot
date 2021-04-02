module EventsActions
  module Callbacks
    module Bank
      def bank_callback_query(event_id = nil, *)
        operation = Event::Operation::Show.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          Event::Operation::Response::Bank::Success.call(payload: payload, current_user: current_user, operation: operation)
        else
          Shared::Operation::Response::Failure.call(payload: payload, current_user: current_user, operation: operation, callback: true)
        end
      end
    end
  end
end