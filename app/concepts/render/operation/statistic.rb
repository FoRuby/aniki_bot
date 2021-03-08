module Render::Operation
  class Statistic < Trailblazer::Operation
    attr_reader :current_user

    step :assign_attributes
    step :response

    def assign_attributes(options, current_user:, **)
      @current_user = current_user
    end

    def response(options, **)
      options[:response] = { text: text }
    end

    def text
      top_borrower = current_user.top_borrower&.tag || 'N/D'
      top_creditor = current_user.top_creditor&.tag || 'N/D'

      "Statistic:\n" \
      "#{"Total spend | #{current_user.total_spend}\n" \
      "Total events | #{current_user.user_events.count}\n" \
      "Total borrowed | #{current_user.total_borrowed}\n" \
      "Top borrower | #{top_borrower}\n" \
      "Total credited | #{current_user.total_credited}\n" \
      "Top creditor | #{top_creditor}"}"
    end
  end
end