module Event::Operation::Render
  class Bank < Event::Operation::Render::Base
    def render
      @render ||= { text: text }
    end

    def text
      event.user_events.includes(:user).map { |i| "#{i.user.tag} | #{i.payment.format}" }.join("\n")
    end
  end
end