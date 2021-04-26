module Refill::Parser
  class Create < Shared::Parser::Base
    def parse
      attributes.merge!({ value: value })
    end

    def value
      params.first.to_f.abs * -1
    end
  end
end