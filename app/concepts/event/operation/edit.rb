module Event::Operation
  class Edit < Trailblazer::Operation
    step Model(Event, :find_by)
    step Policy::Pundit(EventPolicy, :edit?)
    step Contract::Build(constant: Event::Contract::Edit)
    step Contract::Validate()
  end
end

