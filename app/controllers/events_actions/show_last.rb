module EventsActions
  module ShowLast
    include EventsActions::Callbacks::Join
    include EventsActions::Callbacks::Leave
    include EventsActions::Callbacks::Bank
    include EventsActions::Callbacks::Pay
    include EventsActions::Callbacks::RefreshShow
    include EventsActions::Callbacks::Edit

    def last_event!(*args)
      operation = Event::Operation::ShowLast.call(current_user: current_user)
      if operation.success?
        Event::Operation::Response::Show::Success.call(payload: payload, current_user: current_user, operation: operation)
      else
        Event::Operation::Response::Show::Failure.call(payload: payload, current_user: current_user, operation: operation)
      end
    end
  end
end
