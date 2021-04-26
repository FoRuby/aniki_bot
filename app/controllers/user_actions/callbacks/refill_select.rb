module UserActions
  module Callbacks
    module RefillSelect
      def refill_select_callback_query(user_id = nil, *)
        User::Response::RefillSelect::Success.call(current_user, nil, payload)
      end
    end
  end
end

