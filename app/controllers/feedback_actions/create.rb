module FeedbackActions
  module Create
    def feedback!(*args)
      operation = Feedback::Operation::Create.call(current_user: current_user, params: Feedback::Parser::Base.call(args))
      if operation.success?
        Feedback::Operation::Response::Create::Success.call(payload: payload, current_user: current_user, operation: operation)
      else
        Shared::Operation::Response::Failure.call(payload: payload, current_user: current_user, operation: operation)
      end
    end
  end
end