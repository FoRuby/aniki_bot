module Event::Response::Close::Confirmation
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message(render).deep_symbolize_keys
    end

    def render
      Shared::Render::Confirmation.call(
        current_user: current_user,
        positive_callback: "close_event:#{model.id}"
      )
    end
  end
end
