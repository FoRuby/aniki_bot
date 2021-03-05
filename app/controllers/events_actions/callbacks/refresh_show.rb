module EventsActions::Callbacks::RefreshShow
  def refresh_show_callback_query(event_id = nil, *)
    operation = Event::Operation::Show.call(current_user: current_user, params: { id: event_id })
    if operation.success?
      rerender_event operation[:model]
    else
      answer_callback_query(render_errors(operation), show_alert: true)
    end
  rescue Telegram::Bot::Error => e
    puts "Rescued: #{e.inspect}"
  end
end