module Shared::Parser
  class Base
    attr_reader :attributes, :params

    def initialize(params)
      @params = params
      @attributes = {}
    end

    def self.call(...)
      new(...).parse
    end

    def parse; end
  end
end