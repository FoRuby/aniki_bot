module Event::Validation
  class Close < Shared::Contract::DryValidationBase
    config.messages.namespace = :event

    params do
      required(:id).filled(:integer)
      required(:status).filled(:symbol)
      required(:event).filled(type?: Event)
    end

    rule(:event).validate(:open_event?)
  end
end
