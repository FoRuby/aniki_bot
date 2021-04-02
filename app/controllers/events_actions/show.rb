module EventsActions
  module Show
    include EventsActions::Callbacks::Join
    include EventsActions::Callbacks::Leave
    include EventsActions::Callbacks::Bank
    include EventsActions::Callbacks::Pay
    include EventsActions::Callbacks::Edit

    def event!(*args)
      operation = Event::Operation::Show.call(current_user: current_user, params: { id: args.first })
      if operation.success?
        Event::Response::Show::Success.call(current_user, operation, payload)
      else
        Shared::Response::Failure.call(current_user, operation, payload)
      end
    end
  end
end
