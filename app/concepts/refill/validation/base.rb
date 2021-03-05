module Refill::Validation
  class Base < Shared::ApplicationContract
    config.messages.namespace = :refill

    params do
      required(:from_user).filled(type?: User)
      required(:to_user).filled(type?: User)
      required(:value).filled(type?: Money)
    end

    rule(:value) do
      key.failure(:greater_then) unless value.positive?
    end
  end
end
