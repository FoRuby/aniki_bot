module Event::Response::Show
  class Success < Shared::Response::Success
    def success_respond
      send_message
    end

    def send_message
      @message = bot.send_message(render.merge(chat_id: chat_id)).deep_symbolize_keys
    end

    def render
      Event::Render::Show.call(event: model, current_user: current_user)
    end
  end
end
