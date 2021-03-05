module Debt::Validation
  class UpdateFromRefill < Shared::ApplicationContract
    config.messages.namespace = :debt

    params do
      required(:debt).filled(type?: Money)
    end
  end
end
