module Event::Validation
  class Edit < Shared::Contract::DryValidationBase
    config.messages.namespace = :event

    params do
      required(:id).filled(:integer)
      required(:event).filled(type?: Event)
    end

    rule(:event).validate(:open_event?)
  end
end
