module EventsActions::Callbacks::Pay
  def pay_callback_query(event_id = nil, *)
    operation = UserEvent::Operation::Edit.call(
      current_user: current_user,
      params: { user_id: current_user.id, event_id: event_id }
    )
    if operation.success?
      bot.send_message chat_id: current_user.chat_id, text: t('.success')
      save_context :pay
      session[:event_id] = event_id
    else
      answer_callback_query(render_errors(operation), show_alert: true)
    end
  end

  def pay(*args)
    return unless current_user.chat_id == payload['chat']['id']

    operation = UserEvent::Operation::Update.call(
      current_user: current_user,
      params: { user_id: current_user.id, event_id: session[:event_id], payment: args.first.to_f }
    )
    if operation.success?
      bot.send_message chat_id: current_user.chat_id, text: t('.success')
    else
      bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
    end
  end
end