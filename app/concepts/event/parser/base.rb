module Event::Parser
  class Base < Shared::ApplicationParser
    def parse
      parse_attributes
      attributes
    end

    def parse_attributes
      attributes[:name] = params.first
      attributes[:date] = params[1..2]&.join(' ')
    end
  end
end