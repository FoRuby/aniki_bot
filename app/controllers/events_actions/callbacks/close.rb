module EventsActions::Callbacks::Close
  def close_callback_query(event_id = nil, *)
    operation = Event::Operation::Close.call(current_user: current_user, params: { id: event_id })
    if operation.success?
      reply_with :message, text: t('.success'), parse_mode: 'html'
    else
      answer_callback_query(render_errors(operation), show_alert: true)
    end
  end
end