module Event::Parser
  class Update < Shared::Parser::Base
    TIME_REGEXP = /\d{2}:\d{2}/.freeze
    DATE_REGEXP = /\d{4}-\d{2}-\d{2}/.freeze

    attr_reader :input

    def initialize(params)
      @input = params.join(' ')
      super
    end

    def parse
      attributes[:name] = name if name.present?
      attributes[:date] = date if date.present?
      attributes
    end

    def name
      input.gsub(DATE_REGEXP, '').gsub(TIME_REGEXP, '').strip
    end

    def date
      "#{input.scan(DATE_REGEXP).last} #{input.scan(TIME_REGEXP).last}".strip
    end
  end
end