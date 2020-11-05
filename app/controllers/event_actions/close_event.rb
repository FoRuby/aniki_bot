module EventActions::CloseEvent
  def close_event!(*args)
    interactor = CloseEvent.call(user: current_user, event_id: args.first)
    if interactor.success?
      message = "Event was close. See your payers on /my_debtors"
      reply_with :message, text: message, parse_mode: 'html'
    else
      render_errors interactor.errors
    end
  end
end