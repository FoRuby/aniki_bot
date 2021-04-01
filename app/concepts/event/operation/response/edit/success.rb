module Event::Operation::Response::Edit
  class Success < Event::Operation::Response::Create::Success
    def success_respond
      respond_msg
    end

    def respond_msg
      @respond_msg ||= bot.send_message(render).deep_symbolize_keys
    end

    def render
      Event::Operation::Render::Edit.call(event: operation[:model], current_user: current_user)
    end
  end
end
