module Event::Response::Bank
  class Success < Shared::Response::Success
    def success_respond
      respond_msg
    end

    def respond_msg
      @respond_msg ||= bot.send_message(render).deep_symbolize_keys
    end

    def render
      Event::Render::Bank.call(event: operation[:model], current_user: current_user)
    end
  end
end
