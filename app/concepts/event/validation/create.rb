module Event::Validation
  class Create < Shared::Contract::Base
    config.messages.namespace = :event

    DATE_FORMAT = /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}(:\d{2})?\z/.freeze

    params do
      required(:name).filled(:string)
      required(:status).filled(:symbol)
      required(:description).value(:string)
      required(:date_string).filled(:string, format?: DATE_FORMAT)
    end

    rule(:date_string).validate(:future?)
  end
end
