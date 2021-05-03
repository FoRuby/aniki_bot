module Event::Response::Edit
  class Success < Event::Response::Create::Success
    def success_respond
      bot.send_message render
    end

    def render
      Event::Render::Edit.call(event: model, current_user: current_user)
    end
  end
end
