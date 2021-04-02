module User::Operation::Response::Me
  class Success < Shared::Operation::Response::Success
    def success_respond
      bot.send_message(render).deep_symbolize_keys
    end

    def render
      User::Operation::Render::Me.call(current_user: current_user)
    end
  end
end
