module Event::Operation
  class ShowLast < Trailblazer::Operation
    step :model!
    step Policy::Pundit(EventPolicy, :show_last?)

    def model!(options, current_user:, **)
      options[:model] = current_user.events.last
    end
  end
end

