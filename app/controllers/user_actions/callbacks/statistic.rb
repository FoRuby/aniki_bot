module UserActions
  module Callbacks
    module Statistic
      def statistic_callback_query(user_id = nil, *)
        response = Render::Operation::Statistic.call(current_user: current_user)[:response]
        respond_with :message, response
      end
    end
  end
end

