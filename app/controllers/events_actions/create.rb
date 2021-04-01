module EventsActions
  module Create
    def create_event!(*args)
      operation = Event::Operation::Create.call(current_user: current_user, params: Event::Parser::Base.call(args))
      if operation.success?
        Event::Operation::Response::Create::Success.call(payload: payload, current_user: current_user, operation: operation)
      else
        Event::Operation::Response::Create::Failure.call(payload: payload, current_user: current_user, operation: operation)
      end
    end
  end
end