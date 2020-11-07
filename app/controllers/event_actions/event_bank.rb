module EventActions::EventBank
  def event_bank!(*args)
    interactor = EventBank.call(event_id: args.first)
    if interactor.success?
      message = render_event_bank(event: interactor.event)
      reply_with :message, text: t('.success', message: message), parse_mode: 'html'
    else
      render_errors interactor.errors
    end
  end
end