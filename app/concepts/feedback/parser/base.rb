module Feedback::Parser
  class Base < Shared::ApplicationParser
    def parse
      { message: params.join(' ') }
    end
  end
end