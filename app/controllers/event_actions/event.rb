module EventActions::Event
  def event!(*args)
    interactor = Event::Find.call(event_id: args.first)
    if interactor.success?
      render_event(event: interactor.event)
    else
      render_errors interactor.errors
    end
  end

  def join_callback_query(event_id = nil, *)
    interactor = AddUserToEvent.call(event_id: event_id, user: current_user)
    if interactor.success?
      rerender_event(event: interactor.event, chat_id: chat_id, message_id: message_id)
      answer_callback_query('You have joined the event', show_alert: true)
    else
      answer_callback_query(render_errors(interactor.errors), show_alert: true)
    end
  end

  def leave_callback_query(event_id = nil, *)
    interactor = DeleteUserFromEvent.call(event_id: event_id, user: current_user)
    if interactor.success?
      rerender_event(event: interactor.event, chat_id: chat_id, message_id: message_id)
      answer_callback_query('You left the event', show_alert: true)
    else
      answer_callback_query(render_errors(interactor.errors), show_alert: true)
    end
  end

  def bank_callback_query(event_id = nil, *)
    interactor = EventBank.call(event_id: event_id)
    if interactor.success?
      message = render_event_bank(interactor.event)
      bot.send_message chat_id: current_user.chat_id, text: message, parse_mode: 'html'
    else
      bot.send_message chat_id: current_user.chat_id, text: render_errors(interactor.errors)
    end
  end

  def pay_callback_query(event_id = nil, *)
    session[:event_id] = event_id.to_i
    save_context :pay_hendler
    message = 'Enter event payment'
    bot.send_message chat_id: current_user.chat_id, text: message
  end

  def pay_hendler(*args)
    return unless current_user.chat_id == payload['chat']['id']

    interactor = EventPayment.call(event_id: session[:event_id], payment: args.first, user: current_user)
    if interactor.success?
      bot.send_message chat_id: current_user.chat_id, text: 'Payment accepted'
    else
      bot.send_message chat_id: current_user.chat_id, text: render_errors(interactor.errors)
    end
  end

  def message_id
    payload['message']['message_id']
  end

  def chat_id
    payload['message']['chat']['id']
  end

  def render_errors(errors)
    errors.map { |m| "#{m} \n" }.join
  end

  def render_event(event:)
    message = render_event_header(event)
    respond_with :message, text: message, parse_mode: 'html', reply_markup: reply_markup(event)
  end

  def rerender_event(event:, chat_id:, message_id:)
    message = render_event_header(event)
    edit_message 'text',
                 chat_id: chat_id,
                 message_id: message_id,
                 text: message,
                 parse_mode: 'html',
                 reply_markup: reply_markup(event)
  end

  def reply_markup(event)
    {
      inline_keyboard: [
        [
          { text: 'join', callback_data: "join:#{event.id}" },
          { text: 'leave', callback_data: "leave:#{event.id}" }
        ],
        [{ text: 'pay', callback_data: "pay:#{event.id}"}],
        [{ text: 'bank', callback_data: "bank:#{event.id}"}]
      ]
    }
  end
end
