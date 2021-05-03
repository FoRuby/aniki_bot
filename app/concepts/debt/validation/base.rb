module Debt::Validation
  class Base < Shared::Contract::DryValidationBase
    config.messages.namespace = :debt

    params do
      required(:creditor).filled(type?: User)
      required(:borrower).filled(type?: User)
      required(:value).filled(type?: Money)
    end

    rule :value do
      key.failure(:positive) if value.negative?
    end
  end
end
