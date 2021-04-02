module User::Operation::Render
  class Me < Shared::Render::Base
    def render
      @render ||= { text: text, parse_mode: 'html', chat_id: current_user.chat_id, reply_markup: reply_markup }
    end

    def text
      'Select option:'
    end

    def reply_markup
      {
        inline_keyboard: [
          [{ text: 'Finance', callback_data: "finance:#{current_user.id}" }],
          [{ text: 'Statistic', callback_data: "statistic:#{current_user.id}" }],
          [{ text: 'Refill', callback_data: "refill_borrower_select:#{current_user.id}" }],
          [{ text: 'Compensation', callback_data: "compensation_select:#{current_user.id}" }]
        ]
      }
    end
  end
end