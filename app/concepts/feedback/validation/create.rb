module Feedback::Validation
  class Create < Shared::Contract::DryValidationBase
    config.messages.namespace = :feedback

    params do
      required(:user_id).filled(:integer)
      required(:message).filled(:string)
    end
  end
end
