module Event::Operation::Render
  class Base
    attr_reader :event, :current_user

    def initialize(event:, current_user:)
      @event = event
      @current_user = current_user
    end

    def self.call(...)
      new(...).render
    end
  end
end