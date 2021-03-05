module Refill::Validation
  class UpdateFromRefill < Shared::ApplicationContract
    config.messages.namespace = :refill

    params do
      required(:value).filled(type?: Money)
    end
  end
end
