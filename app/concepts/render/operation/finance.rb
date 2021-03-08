module Render::Operation
  class Finance < Trailblazer::Operation
    attr_reader :current_user

    step :assign_attributes
    step :response

    def assign_attributes(options, current_user: nil, **)
      @current_user = current_user
      true
    end

    def response(options, **)
      options[:response] = { text: text }
    end

    def text
      borrowers + creditors
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