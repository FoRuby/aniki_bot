module Event::Render
  class Base < Shared::Render::Base
    attr_reader :event

    def initialize(event:, **args)
      super(**args)
      @event = event
    end
  end
end