module Feedback::Validation
  class Create < Shared::ApplicationContract
    config.messages.namespace = :feedback

    params do
      required(:message).filled(:string)
      required(:user_id).filled(:integer)
    end
  end
end
