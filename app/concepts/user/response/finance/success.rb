module User::Response::Finance
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message render
    end

    def render
      User::Render::Finance.call(current_user: current_user)
    end
  end
end