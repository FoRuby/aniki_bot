module Event::Render
  class Show < Event::Render::Base
    def render
      @render ||= { text: text, parse_mode: 'html', reply_markup: reply_markup }
    end

    def text
      "Event info:\n" \
      "ID: #{event.id}\n" \
      "Name: #{event.name}\n" \
      "Date: #{event.date.to_formatted_s(:long)}\n" \
      "Users(#{event.users.count}): #{event.users.map(&:tag).join(' ')}\n" \
      "Bank: #{event.bank.format}\n"
    end

    def reply_markup
      {
        inline_keyboard: [
          [
            { text: 'Join', callback_data: "join_event:#{event.id}" },
            { text: 'Leave', callback_data: "leave_event:#{event.id}" }
          ],
          [{ text: 'Pay', callback_data: "pay_event:#{event.id}" }],
          [{ text: 'Info', callback_data: "info_event:#{event.id}" }],
          [{ text: 'Edit', callback_data: "edit_event:#{event.id}" }]
        ]
      }
    end
  end
end