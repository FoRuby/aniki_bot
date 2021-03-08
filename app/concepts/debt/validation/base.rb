module Debt::Validation
  class Base < Shared::ApplicationContract
    config.messages.namespace = :debt

    params do
      required(:creditor).filled(type?: User)
      required(:borrower).filled(type?: User)
      required(:value).filled(type?: Money)
    end

    rule :value do
      key.failure(:greater_then) if value <= 0
    end
  end
end
