module User::Operation
  class Create < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(name: :create_user, constant: User::Contract::Create)
    step Contract::Validate(name: :create_user)
    step Contract::Persist(name: :create_user)
  end
end