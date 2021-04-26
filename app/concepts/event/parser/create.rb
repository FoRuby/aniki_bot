module Event::Parser
  class Create < Shared::Parser::Base
    TIME_REGEXP = /\d{2}:\d{2}/.freeze
    DATE_REGEXP = /\d{4}-\d{2}-\d{2}/.freeze

    attr_reader :input

    def initialize(params)
      @input = params.join(' ')
      super
    end

    def parse
      { name: name, date: date }
    end

    def name
      name = input.gsub(DATE_REGEXP, '').gsub(TIME_REGEXP, '').strip
      name.blank? ? 'New Event' : name
    end

    def date
      "#{input.scan(DATE_REGEXP).last || Date.today} #{input.scan(TIME_REGEXP).last || (Time.now + 1.hour).beginning_of_hour.strftime('%H:%M')}".strip
    end
  end
end