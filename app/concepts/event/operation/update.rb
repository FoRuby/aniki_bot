module Event::Operation
  class Update < Trailblazer::Operation
    step Model(Event, :find_by)
    step Policy::Pundit(EventPolicy, :update?)
    step Contract::Build(constant: Event::Contract::Update)
    step Contract::Validate()
    step Contract::Persist()
  end
end