module UserActions
  module Callbacks
    module Finance
      def finance_callback_query(user_id = nil, *)
        User::Response::Finance::Success.call(current_user, nil, payload)
      end
    end
  end
end

