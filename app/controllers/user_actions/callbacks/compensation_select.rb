module UserActions
  module Callbacks
    module CompensationSelect
      def compensation_select_callback_query(user_id = nil, *)
        User::Response::CompensationSelect::Success.call(current_user, nil, payload)
      end
    end
  end
end

