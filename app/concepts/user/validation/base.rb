module User::Validation
  class Base < Shared::Contract::DryValidationBase
    config.messages.namespace = :user

    params do
      required(:first_name).filled(:string)
      required(:chat_id).filled(:integer)

      optional(:last_name).maybe(:string)
      optional(:username).maybe(:string)
    end
  end
end
