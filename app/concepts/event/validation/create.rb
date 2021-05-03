module Event::Validation
  class Create < Shared::Contract::DryValidationBase
    config.messages.namespace = :event

    params do
      required(:name).filled(:string)
      required(:status).filled(:symbol)
      required(:description).value(:string)
      required(:date).filled(:time)
    end

    rule(:date).validate(:future?)
  end
end
