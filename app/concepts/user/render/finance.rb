module User::Render
  class Finance < Shared::Render::Base
    def render
      @render ||= { text: borrowers + creditors, chat_id: current_user.chat_id }
    end

    def borrowers
      message = current_user.user_borrowers.positive.includes(:borrower).map do |debt|
        "#{debt.borrower.tag} | #{debt.value.format}\n"
      end.join
      return "You have not Borrowers\n" if message.empty?

      "Your Borrowers:\n#{message}"
    end

    def creditors
      message = current_user.user_creditors.positive.includes(:creditor).map do |debt|
        "#{debt.creditor.tag} | #{debt.value.format}\n"
      end.join
      return "You have not Creditors\n" if message.empty?

      "Your Creditors:\n#{message}"
    end
  end
end