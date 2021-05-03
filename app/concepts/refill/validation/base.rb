module Refill::Validation
  class Base < Shared::Contract::DryValidationBase
    config.messages.namespace = :refill

    params do
      required(:debt_id).filled(:integer)
      required(:value).filled(type?: Money)
    end
  end
end
