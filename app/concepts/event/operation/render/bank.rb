module Event::Operation::Render
  class Bank < Event::Operation::Render::Base
    def self.call(...)
      new(...).bank
    end

    def bank
      @bank ||= event.user_events.includes(:user).map { |i| "#{i.user.tag} | #{i.payment.format}" }.join("\n")
    end
  end
end