module Event::Render
  class Bank < Event::Render::Base
    def render
      @render ||= { text: text, chat_id: current_user.chat_id }
    end

    def text
      payments + costs
    end

    def payments
      str = event.user_events.includes(:user).map { |i| "#{i.user.tag} | #{i.payment.format}" }.join("\n")
      str.present? ? "#{str.prepend("Payments:\n")}\n" : 'There are no users in the event'
    end

    def costs
      str = event.user_events.includes(:user).map do |i|
        "#{i.user.tag} | #{i.cost.format}" if i.cost.positive?
      end.join("\n")
      str.present? ? str.prepend("Costs:\n") : ''
    end

    def default_cost
      @default_cost ||= event.user_events.map(&:payment).sum / event.user_events.count
    end
  end
end