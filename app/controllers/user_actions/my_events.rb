module UserActions::MyEvents
  def my_events!(*args)
    events = current_user.events
    if events.any?
      reply_with :message, text: t('.success', message: render_events(events))
    else
      reply_with :message, text: t('.failure')
    end
  end

  def render_events(events)
    events.map { |event| "ID: #{event.id} | Name:  #{event.name} | Date: #{event.date.to_formatted_s(:long)} \n" }.join
  end
end