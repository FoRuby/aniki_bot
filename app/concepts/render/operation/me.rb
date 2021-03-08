module Render::Operation
  class Me < Trailblazer::Operation
    attr_reader :current_user

    step :assign_attributes
    step :response

    def assign_attributes(options, current_user: nil, **)
      @current_user = current_user
      true
    end

    def response(options, **)
      options[:response] = { text: text, parse_mode: 'html', reply_markup: reply_markup }
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