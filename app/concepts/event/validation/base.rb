module Event::Validation
  class Base < Shared::Contract::Base
    config.messages.namespace = :event

    DATE_FORMAT = /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}(:\d{2})?\z/.freeze

    params do
      required(:name).filled(:string)
      required(:date).filled(:string, format?: DATE_FORMAT)
      required(:status).filled(:symbol)
    end

    rule :date do
      key.failure(:already_past) if value.to_time.past?
    rescue ArgumentError
      key.failure(:invalid)
    end
  end
end
