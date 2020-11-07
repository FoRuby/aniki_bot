module EventActions::EventInfo
  # def event_info!(*args)
  #   interactor = Event::Find.call(event_id: args.first)
  #   if interactor.success?
  #     message = 'Event:' + render_event(interactor.event)
  #     reply_with :message, text: t('.success', message: message), parse_mode: 'html'
  #   else
  #     render_errors interactor.errors
  #   end
  # end
end