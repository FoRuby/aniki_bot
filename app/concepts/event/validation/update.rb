module Event::Validation
  class Update < Shared::Contract::DryValidationBase
    config.messages.namespace = :event

    params do
      required(:id).filled(:integer)
      required(:name).filled(:string)
      required(:description).value(:string)
      required(:date).filled(:time)
      required(:status).filled(:symbol)
      required(:event).filled(type?: Event)
    end

    rule(:date).validate(:future?)
    rule(:event).validate(:open_event?)
  end
end
