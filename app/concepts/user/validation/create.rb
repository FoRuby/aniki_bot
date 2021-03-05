module User::Validation
  class Create < User::Validation::Base
    params do
      required(:chat_id).filled(:integer)
    end

    rule(:chat_id) do
      key.failure(:exist) if User.where(chat_id: value).exists?
    end
  end
end
