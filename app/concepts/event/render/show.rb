module Event::Render
  class Show < Event::Render::Base
    def render
      @render ||= { text: text, parse_mode: 'html', reply_markup: reply_markup }
    end

    def text
      date = event.date.to_formatted_s(:long)
      bank = event.bank
      users = event.users.map(&:tag).join(' ')
      "Event info:\nID: #{event.id}\nName: #{event.name}\nDate: #{date}\nUsers(#{event.users.count}): #{users}\nBank: #{bank}\n"
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
            { text: 'Cost', callback_data: "cost:#{event.id}" }
          ],
          [{ text: 'Bank', callback_data: "bank:#{event.id}" }],
          [{ text: 'Edit', callback_data: "edit_event:#{event.id}" }]
        ]
      }
    end
  end
end