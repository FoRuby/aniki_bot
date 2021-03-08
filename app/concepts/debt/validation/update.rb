module Debt::Validation
  class Update < Shared::ApplicationContract
    config.messages.namespace = :debt

    params do
      required(:value).filled(type?: Money)
      required(:debt).filled(type?: Debt)
    end

    rule(:value) do
      key.failure(:greater_then) if value.negative?
    end
  end
end
