module Feedback::Validation
  class Create < Shared::Contract::Base
    config.messages.namespace = :feedback

    params do
      required(:message).filled(:string)
      required(:user_id).filled(:integer)
    end
  end
end
