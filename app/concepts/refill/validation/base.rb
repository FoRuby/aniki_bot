module Refill::Validation
  class Base < Shared::Contract::Base
    config.messages.namespace = :refill

    params do
      required(:value).filled(type?: Money)
    end
  end
end
