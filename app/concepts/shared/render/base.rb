module Shared::Render
  class Base
    attr_reader :current_user

    def initialize(current_user:)
      @current_user = current_user
    end

    def self.call(...)
      new(...).render
    end

    def render; end
  end
end