module Feedback::Parser
  class Base < Shared::Parser::Base
    def parse
      attributes.merge({ message: params.join(' ') })
    end
  end
end