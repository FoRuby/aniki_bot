module EventsActions
  module ShowLast
    def last_event!(*args)
      operation = Event::Operation::ShowLast.call(current_user: current_user)
      if operation.success?
        Event::Response::Show::Success.call(current_user, operation, payload)
      else
        Shared::Response::Failure.call(current_user, operation, payload)
      end
    end
  end
end
