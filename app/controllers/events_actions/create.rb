module EventsActions
  module Create
    def create_event!(*args)
      operation = Event::Operation::Create.call(current_user: current_user, params: Event::Parser::Create.call(args))
      if operation.success?
        Event::Response::Create::Success.call(current_user, operation, payload)
      else
        Shared::Response::Failure.call(current_user, operation, payload)
      end
    end
  end
end