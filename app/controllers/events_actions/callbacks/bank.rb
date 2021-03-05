module EventsActions::Callbacks::Bank
  def bank_callback_query(event_id = nil, *)
    operation = Event::Operation::Show.call(current_user: current_user, params: { id: event_id })
    if operation.success?
      bot.send_message chat_id: current_user.chat_id, text: render_event_bank(operation[:model]), parse_mode: 'html'
    else
      answer_callback_query(render_errors(operation), show_alert: true)
    end
  end

  def render_event_bank(event)
    event.user_events.map { |i| "#{i.user.tag} | #{i.payment.format}" }.join("\n")
  end
end