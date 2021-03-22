module Render::Operation
  class EditEvent < Trailblazer::Operation
    attr_reader :event, :current_user

    step :assign_attributes
    step :response

    def assign_attributes(options, event: nil, current_user: nil, **)
      @event = event
      @current_user = current_user
      true
    end

    def response(options, current_user:, **)
      options[:response] = { text: text, chat_id: current_user.chat_id, parse_mode: 'html', reply_markup: reply_markup }
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
          [{ text: 'Close', callback_data: "close:#{event.id}" }],
          [{ text: 'Update', callback_data: "update:#{event.id}" }],
          [{ text: 'Kick User', callback_data: "kick_select:#{event.id}" }],
          [{ text: 'Refresh', callback_data: "refresh_edit:#{event.id}" }]
        ]
      }
    end
  end
end