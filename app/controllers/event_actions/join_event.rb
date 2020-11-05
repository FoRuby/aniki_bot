module EventActions::JoinEvent
  def join_event!(*args)
    interactor = AddUserToEvent.call(user: current_user, event_id: args.first)
    if interactor.success?
      message = "#{current_user.usertag} joined to Event" + render_event(interactor.event)
      reply_with :message, text: t('.success', message: message), parse_mode: 'html'
    else
      render_errors interactor.errors
    end
  end
end