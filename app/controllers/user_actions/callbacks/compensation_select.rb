module UserActions
  module Callbacks
    module CompensationSelect
      def compensation_select_callback_query(user_id = nil, *)
        render = Render::Operation::CompensationSelect.call(current_user: current_user)
        render.success? ? respond_with(:message, render[:response]) : answer_callback_query(render[:response], show_alert: true)
      end
    end
  end
end

