module User::Render
  class Statistic < Shared::Render::Base
    def render
      { text: text, chat_id: current_user.chat_id }
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