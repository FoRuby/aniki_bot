module UserEvent::Operation
  class Create < Trailblazer::Operation
    step Model(UserEvent, :new)
    step Policy::Pundit(UserEventPolicy, :create?)
    step Contract::Build(constant: UserEvent::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
  end
end