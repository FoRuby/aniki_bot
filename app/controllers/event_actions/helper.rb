module EventActions::Helper
  def render_event_header(event)
    date = event.date.to_formatted_s(:long)
    users = event.users&.map(&:usertag).join(' ') || ''
    "Event info: \n" +
    "ID: #{event.id} \n" +
    "Name: #{event.name} \n" +
    "Date: #{date} \n" +
    "Users: #{users} \n"
  end

  def render_event_bank(event)
    users = event.user_events.map { |i| "#{i.user.usertag} => #{i.payment.format} \n" }.join || 'No one pay'
    render_event_header(event) + users
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