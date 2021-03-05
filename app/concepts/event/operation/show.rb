module Event::Operation
  class Show < Trailblazer::Operation
    step Model(Event, :find_by)
    step Policy::Pundit(EventPolicy, :show?)
  end
end

