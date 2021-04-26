module Event::Parser
  class Description < Shared::Parser::Base
    def parse
      attributes.merge({ description: params['text'] })
    end
  end
end