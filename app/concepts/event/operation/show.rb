module Event::Operation
  # Event::Operation::Show.call(current_user: current_user, params: { id: id })
  class Show < Trailblazer::Operation
    step Model(Event, :find_by)
    step Policy::Pundit(EventPolicy, :show?)
  end
end

