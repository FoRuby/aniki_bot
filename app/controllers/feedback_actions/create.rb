module FeedbackActions
  module Create
    def feedback!(*args)
      operation = Feedback::Operation::Create.call(
        current_user: current_user, params: Feedback::Parser::Base.call(args)
      )
      if operation.success?
        Feedback::Response::Create::Success.call(current_user, operation, payload)
      else
        Shared::Response::Failure.call(current_user, operation, payload)
      end
    end
  end
end