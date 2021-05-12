module User::Render
  class Finance < Shared::Render::Base
    def render
      { text: text, chat_id: current_user.chat_id }
    end

    def text
      borrowers + creditors
    end

    def borrowers
      message = current_user.user_borrowers.positive.includes(:borrower).map do |debt|
        "#{debt.borrower.tag} | #{debt.value.format}"
      end.join("\n")
      return "You have not Borrowers\n" if message.empty?

      "Your Borrowers:\n#{message}\n"
    end

    def creditors
      message = current_user.user_creditors.positive.includes(:creditor).map do |debt|
        "#{debt.creditor.tag} | #{debt.value.format}"
      end.join("\n")
      return "You have not Creditors\n" if message.empty?

      "Your Creditors:\n#{message}\n"
    end
  end
end