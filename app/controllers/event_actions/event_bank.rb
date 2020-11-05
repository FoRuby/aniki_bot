module EventActions::EventBank
  def event_bank!(*args)
    interactor = EventBank.call(event_id: args.first)
    if interactor.success?
      message = render_event_bank(event: interactor.event, user_events: interactor.user_events)
      reply_with :message, text: t('.success', message: message), parse_mode: 'html'
    else
      render_errors interactor.errors
    end
  end

  def render_event_bank(event:, user_events:)
    "Event: \n" +
        "ID: #{event.id} | Name: #{event.name} | Date: #{event.date.to_formatted_s(:long)} \n" +
        user_events.map { |i| "#{i.user.usertag} => #{i.payment.format} \n" }.join
  end
end