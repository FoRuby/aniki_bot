module EventsActions::Callbacks::KickSelect
  def kick_select_callback_query(event_id = nil, *)
    operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
    if operation.success?
      session[:event_id] = event_id.to_i
      render_kick_select(operation[:model])
    else
      answer_callback_query(render_errors(operation), show_alert: true)
    end
  end

  def render_kick_select(event)
    respond_with :message,
                 text: 'Select User',
                 parse_mode: 'html',
                 reply_markup: select_kick_user_reply_markup(event)
  end

  def select_kick_user_reply_markup(event)
    inline_keyboard = event.users.where.not(id: current_user.id).each_with_object([]) do |user, arr|
      arr << [{ text: user.tag, callback_data: "kick:#{user.id}" }]
    end
    { inline_keyboard: inline_keyboard }
  end
end

