module UserActions
  module Callbacks
    module Compensation
      def compensation_callback_query(opponent_id = nil, *)
        operation = Debt::Operation::Compensation.call(current_user: current_user, params: { opponent_id: opponent_id })
        if operation.success?
          User::Response::Compensation::Success.call(current_user, operation, payload)
        else
          User::Response::Compensation::Failure.call(current_user, operation, payload)
        end
      end
    end
  end
end

