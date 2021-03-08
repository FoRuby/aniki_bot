module Refill::Validation
  class Create < Shared::ApplicationContract
    config.messages.namespace = :refill

    params do
      required(:value).filled(type?: Money)
      required(:debt_id).filled(:integer)
    end

    rule(:value) do
      key.failure(:greater_then) unless value.positive?
    end
  end
end
