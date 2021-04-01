module Event::Operation::Render
  class Show < Event::Operation::Render::Base
    def render
      @render ||= { text: text, parse_mode: 'html', reply_markup: reply_markup }
    end

    def text
      date = event.date.to_formatted_s(:long)
      bank = event.bank
      users = event.users.map(&:tag).join(' ')
      "Event info:\nID: #{event.id}\nName: #{event.name}\nDate: #{date}\nUsers: #{users}\nBank: #{bank}\n"
    end

    def reply_markup
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
  end
end