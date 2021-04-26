module Debt::Validation
  class Update < Shared::Contract::Base
    config.messages.namespace = :debt

    params do
      required(:value).filled(type?: Money)
      optional(:is_compensation).filled(:bool)
      required(:debt).filled(type?: Debt)
    end

    rule(:value) do
      key.failure(:positive) if value.negative?
    end

    rule :value, :debt do
      key(:value).failure(:positive) if values[:value] == values[:debt].value
    end
  end
end
