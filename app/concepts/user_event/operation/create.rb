module UserEvent::Operation
  # UserEvent::Operation::Create.call(current_user: current_user, params: { event_id: event_id, user_id: user_id })
  class Create < Trailblazer::Operation
    step Model(UserEvent, :new)
    step Policy::Pundit(UserEventPolicy, :create?)
    step Contract::Build(constant: UserEvent::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
  end
end