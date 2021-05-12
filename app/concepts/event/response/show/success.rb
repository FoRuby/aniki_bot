module Event::Response::Show
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message(render.merge(chat_id: chat_id))
    end

    def render
      Event::Render::Show.call(event: model, current_user: current_user)
    end
  end
end
