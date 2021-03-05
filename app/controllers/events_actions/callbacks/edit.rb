module EventsActions::Callbacks::Edit
  def edit_event_callback_query(event_id = nil, *)
    operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
    if operation.success?
      render_edit_event operation[:model]
    else
      answer_callback_query(render_errors(operation), show_alert: true)
    end
  end
end