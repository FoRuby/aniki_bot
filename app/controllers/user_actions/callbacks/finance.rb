module UserActions
  module Callbacks
    module Finance
      def finance_callback_query(user_id = nil, *)
        response = Render::Operation::Finance.call(current_user: current_user)[:response]
        respond_with :message, response
      end
    end
  end
end

