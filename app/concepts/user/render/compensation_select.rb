module User::Render
  class CompensationSelect < Shared::Render::Base
    def render
      return if compensation_users.empty?

      @render ||= { text: text, parse_mode: 'html', reply_markup: reply_markup }
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

    def compensation_users
      @compensation_users ||= current_user.positive_borrowers & current_user.positive_creditors
    end
  end
end