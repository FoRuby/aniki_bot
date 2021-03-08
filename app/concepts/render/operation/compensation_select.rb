module Render::Operation
  class CompensationSelect < Trailblazer::Operation
    attr_reader :compensation_users

    step :assign_attributes
    step :compensation_users?
    fail :failure
    step :response

    def assign_attributes(options, current_user:, **)
      @compensation_users = current_user.positive_borrowers & current_user.positive_creditors
    end

    def compensation_users?(options, **)
      @compensation_users.any?
    end

    def response(options, **)
      options[:response] = { text: text, parse_mode: 'html', reply_markup: reply_markup }
    end

    def failure(options, **)
      options[:response] = 'You have not users to compensate'
    end

    def text
      'Select user for Compensation:'
    end

    def reply_markup
      inline_keyboard = compensation_users.each_with_object([]) do |user, arr|
        arr << [{ text: user.tag, callback_data: "compensation:#{user.id}" }]
      end
      { inline_keyboard: inline_keyboard }
    end
  end
end