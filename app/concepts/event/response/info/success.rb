module Event::Response::Info
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message render
    end

    def render
      Event::Render::Info.call(event: model, current_user: current_user)
    end
  end
end
