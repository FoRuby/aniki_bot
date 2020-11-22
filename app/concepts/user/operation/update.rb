module User::Operation
  class Update < Trailblazer::Operation
    step Model(User, :find_by, :chat_id)
    step Contract::Build(name: :update_user, constant: User::Contract::Update)
    step Contract::Validate(name: :update_user)
    step Contract::Persist(name: :update_user)
  end
end