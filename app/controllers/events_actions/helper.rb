module EventsActions::Helper
  def render_event(event)
    respond_with :message,
                 text: event_header(event),
                 parse_mode: 'html',
                 reply_markup: show_event_reply_markup(event)
  end

  def render_edit_event(event)
    bot.send_message chat_id: current_user.chat_id,
                     text: event_header(event),
                     parse_mode: 'html',
                     reply_markup: edit_event_reply_markup(event)
  end

  def rerender_event(event)
    edit_message 'text',
                 chat_id: payload['message']['chat']['id'],
                 message_id: payload['message']['message_id'],
                 text: event_header(event),
                 parse_mode: 'html',
                 reply_markup: show_event_reply_markup(event)
  end

  def rerender_edit_event(event)
    edit_message 'text',
                 chat_id: payload['message']['chat']['id'],
                 message_id: payload['message']['message_id'],
                 text: event_header(event),
                 parse_mode: 'html',
                 reply_markup: edit_event_reply_markup(event)
  end

  def event_header(event)
    date = event.date.to_formatted_s(:long)
    bank = event.bank
    users = event.users.map(&:tag).join(' ')
    "Event info:\nID: #{event.id}\nName: #{event.name}\nDate: #{date}\nUsers: #{users}\nBank: #{bank}\n"
  end

  def show_event_reply_markup(event)
    {
      inline_keyboard: [
        [
          { text: 'Join', callback_data: "join:#{event.id}" },
          { text: 'Leave', callback_data: "leave:#{event.id}" }
        ],
        [
          { text: 'Pay', callback_data: "pay:#{event.id}" },
          { text: 'Bank', callback_data: "bank:#{event.id}" }
        ],
        [{ text: 'Edit', callback_data: "edit_event:#{event.id}" }],
        [{ text: 'Refresh', callback_data: "refresh_show:#{event.id}" }]
      ]
    }
  end

  def edit_event_reply_markup(event)
    {
      inline_keyboard: [
        [{ text: 'Close', callback_data: "close:#{event.id}" }],
        [{ text: 'Update', callback_data: "update:#{event.id}" }],
        [{ text: 'Kick User', callback_data: "kick_select:#{event.id}" }],
        [{ text: 'Refresh', callback_data: "refresh_edit:#{event.id}" }]
      ]
    }
  end
end