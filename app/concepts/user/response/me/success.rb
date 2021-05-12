module User::Response::Me
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message render
    end

    def render
      User::Render::Me.call(current_user: current_user)
    end
  end
end
