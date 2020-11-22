module EventActions::CreateEvent
  def create_event!(*args)
    interactor = CreateEvent.call(user: current_user, event_attributes: args)
    if interactor.success?
      render_event(event: interactor.event)
    else
      bot.send_message chat_id: current_user.chat_id, text: render_errors(interactor.errors)
    end
  end
end