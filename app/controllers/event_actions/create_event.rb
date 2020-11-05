module EventActions::CreateEvent
  def create_event!(*args)
    interactor = CreateEvent.call(user: current_user, event_attributes: args)
    if interactor.success?
      message = "#{current_user.usertag} Create Event" + render_event(interactor.event)
      reply_with :message, text: t('.success', message: message), parse_mode: 'html'
    else
      render_errors interactor.errors
    end
  end
end