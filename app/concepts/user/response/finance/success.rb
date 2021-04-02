module User::Response::Finance
  class Success < Shared::Response::Success
    def success_respond
      respond_msg
    end

    def respond_msg
      @respond_msg ||= bot.send_message(render).deep_symbolize_keys
    end

    def render
      User::Render::Finance.call(current_user: current_user)
    end
  end
end