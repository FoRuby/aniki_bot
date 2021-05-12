module Event::Render
  class Edit < Event::Render::Show
    def render
      { text: text, chat_id: current_user.chat_id, parse_mode: 'html', reply_markup: reply_markup }
    end

    def reply_markup
      {
        inline_keyboard: [
          [{ text: 'Close', callback_data: "close_event:#{event.id}" }],
          [{ text: 'Update', callback_data: "update_event:#{event.id}" }],
          [{ text: 'Add Admin', callback_data: "add_event_admin_select:#{event.id}" }],
          [{ text: "#{description_action} Description", callback_data: "description_event:#{event.id}" }],
          [{ text: 'Kick User', callback_data: "kick_event_select:#{event.id}" }]
        ]
      }
    end

    def description_action
      event.description.present? ? 'Change' : 'Add'
    end
  end
end