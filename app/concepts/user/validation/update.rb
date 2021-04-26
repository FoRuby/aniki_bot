module User::Validation
  class Update < User::Validation::Base
    params do
      required(:id).filled(:integer)
      required(:chat_id).filled(:integer)
    end
  end
end
