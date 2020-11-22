module Shared
  class ApplicationParser
    attr_reader :attributes, :params

    def initialize(params)
      @params = params
      @attributes = {}
    end

    def self.call(...)
      new(...).parse
    end

    def parse; end

    def symbolize_params_keys!
      @params.symbolize_keys!
    end
  end
end