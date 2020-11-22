module User::Validation
  class Create < Shared::ApplicationContract
    params do
      required(:first_name).filled(:string)
      required(:chat_id).filled(:integer)

      optional(:last_name).maybe(:string)
      optional(:username).maybe(:string)
    end

    rule(:chat_id) do
      key.failure(:taken) if User.where(chat_id: values[:chat_id]).exists?
    end
  end
end
