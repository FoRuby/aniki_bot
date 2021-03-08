module UserActions
  module Callbacks
    module RefillBorrowerSelect
      def refill_borrower_select_callback_query(user_id = nil, *)
        render = Render::Operation::RefillSelect.call(current_user: current_user)
        render.success? ? respond_with(:message, render[:response]) : answer_callback_query(render[:response], show_alert: true)
      end
    end
  end
end

