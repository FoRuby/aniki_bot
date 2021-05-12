module Event::Response::Close::Confirmation
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message render
    end

    def render
      Shared::Render::Confirmation.call(
        current_user: current_user,
        positive_callback: { callback_data: "close_event:#{model.id}" }
      )
    end
  end
end
