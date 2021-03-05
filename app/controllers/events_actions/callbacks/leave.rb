module EventsActions::Callbacks::Leave
  def leave_callback_query(event_id = nil, *)
    operation = UserEvent::Operation::Delete.call(current_user: current_user,
                                                  params: { event_id: event_id, user_id: current_user.id })
    if operation.success?
      rerender_event operation[:model].event
      answer_callback_query(t('.success'), show_alert: true)
    else
      answer_callback_query(render_errors(operation), show_alert: true)
    end
  end
end