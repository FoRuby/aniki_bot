module User::Operation
  class Update < Trailblazer::Operation
    step Model(User, :find_by, :chat_id)
    step Contract::Build(constant: User::Contract::Update)
    step Contract::Validate()
    step Contract::Persist()
  end
end