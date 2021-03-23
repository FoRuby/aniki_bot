module Feedback::Parser
  class Base < Shared::ApplicationParser
    def parse
      parse_attributes
      attributes
    end

    def parse_attributes
      attributes[:message] = params&.join(' ')
    end
  end
end