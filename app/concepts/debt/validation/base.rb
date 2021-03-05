module Debt::Validation
  class Base < Shared::ApplicationContract
    config.messages.namespace = :debt

    params do
      required(:creditor).filled(type?: User)
      required(:borrower).filled(type?: User)
      required(:debt).filled(type?: Money)
    end

    rule :debt do
      key.failure(:greater_then_zero) if value <= 0
    end
  end
end
