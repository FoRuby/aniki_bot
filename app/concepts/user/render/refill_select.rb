module User::Render
  class RefillSelect < Shared::Render::Base
    def render
      return if debts.empty?

      { text: text, parse_mode: 'html', reply_markup: reply_markup }
    end

    def text
      'Select Borrower:'
    end

    def reply_markup
      inline_keyboard = debts.each_with_object([]) do |debt, arr|
        arr << [{ text: debt.borrower.tag, callback_data: "refill:#{debt.id}" }]
      end
      { inline_keyboard: inline_keyboard }
    end

    def debts
      @debts ||= current_user.user_borrowers.positive.includes(:borrower)
    end
  end
end