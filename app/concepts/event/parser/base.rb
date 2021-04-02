module Event::Parser
  class Base < Shared::Parser::Base
    def parse
      { name: params[..-3].join(' '), date: params.last(2).join(' ') }
    end
  end
end