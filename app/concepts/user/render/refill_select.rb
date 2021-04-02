module User::Render
  class RefillSelect < Shared::Render::Base
    def render
      return if borrowers.empty?

      @render ||= { text: text, parse_mode: 'html', reply_markup: reply_markup }
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

    def borrowers
      @borrowers ||= current_user.positive_borrowers
    end
  end
end