module User::Validation
  class Update < User::Validation::Base
    params do
      required(:id).filled(:integer)
    end

    rule(:chat_id, :id) do
      key.failure(:exist) unless User.where.not(id: values[:id]).where(chat_id: values[:chat_id]).empty?
    end
  end
end
