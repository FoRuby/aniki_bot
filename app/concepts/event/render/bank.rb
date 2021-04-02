module Event::Render
  class Bank < Event::Render::Base
    def render
      @render ||= { text: text, chat_id: current_user.chat_id }
    end

    def text
      event.user_events.includes(:user).map { |i| "#{i.user.tag} | #{i.payment.format}" }.join("\n")
    end
  end
end