module Feedback::Parser
  class Base < Shared::Parser::Base
    def parse
      { message: params.join(' ') }
    end
  end
end