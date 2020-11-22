module User::Validation
  class Update < Shared::ApplicationContract
    params do
      required(:id).filled(:integer)
      required(:first_name).filled(:string)
      required(:chat_id).filled(:integer)

      optional(:last_name).maybe(:string)
      optional(:username).maybe(:string)
    end

    rule(:chat_id, :id) do
      key.failure(:taken) unless User.where.not(id: values[:id]).where(chat_id: values[:chat_id]).empty?
    end
  end
end
