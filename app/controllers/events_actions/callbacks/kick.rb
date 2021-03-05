module EventsActions::Callbacks::Kick
  def kick_callback_query(user_id = nil, *)
    operation = UserEvent::Operation::Delete.call(current_user: current_user,
                                                  params: { event_id: session[:event_id], user_id: user_id })
    if operation.success?
      render_edit_event operation[:model].event
      answer_callback_query(t('.success', value: operation[:model].user.tag), show_alert: true)
    else
      answer_callback_query(render_errors(operation), show_alert: true)
    end
  end
end