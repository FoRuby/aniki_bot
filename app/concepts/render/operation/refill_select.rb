module Render::Operation
  class RefillSelect < Trailblazer::Operation
    attr_reader :borrowers

    step :assign_attributes
    step :borrowers?
    fail :failure
    step :response

    def assign_attributes(options, current_user:, **)
      @borrowers = current_user.positive_borrowers
    end

    def borrowers?(options, **)
      @borrowers.any?
    end

    def response(options, **)
      options[:response] = { text: text, parse_mode: 'html', reply_markup: reply_markup }
    end

    def failure(options, **)
      options[:response] = 'You have not Borrowers'
    end

    def text
      'Select Borrower:'
    end

    def reply_markup
      inline_keyboard = borrowers.each_with_object([]) do |user, arr|
        arr << [{ text: user.tag, callback_data: "refill_borrower:#{user.id}" }]
      end
      { inline_keyboard: inline_keyboard }
    end
  end
end