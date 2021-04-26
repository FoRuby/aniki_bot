module Event::Validation
  class Update < Shared::Contract::Base
    config.messages.namespace = :event

    DATE_FORMAT = /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}(:\d{2})?\z/.freeze

    params do
      required(:id).filled(:integer)
      required(:event).filled(type?: Event)
      required(:status).filled(:symbol)
      required(:description).value(:string)

      optional(:date_string).maybe(:string, format?: DATE_FORMAT)
    end

    rule(:date_string).validate(:future?)
    rule(:event).validate(:open_event?)
  end
end
