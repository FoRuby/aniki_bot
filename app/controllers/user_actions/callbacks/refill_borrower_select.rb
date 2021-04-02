module UserActions
  module Callbacks
    module RefillBorrowerSelect
      def refill_borrower_select_callback_query(user_id = nil, *)
        User::Response::RefillSelect::Success.call(current_user, nil, payload)
      end
    end
  end
end

