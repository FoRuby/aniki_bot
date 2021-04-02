module UserActions
  module Callbacks
    module Statistic
      def statistic_callback_query(user_id = nil, *)
        User::Response::Statistic::Success.call(current_user, nil, payload)
      end
    end
  end
end

