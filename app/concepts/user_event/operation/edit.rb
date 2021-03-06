module UserEvent::Operation
  # UserEvent::Operation::Edit.call(current_user: current_user, params: { event_id: event_id, user_id: user_id })
  class Edit < Trailblazer::Operation
    step :model!
    step Policy::Pundit(UserEventPolicy, :edit?)
    step Contract::Build(constant: UserEvent::Contract::Edit)
    step Contract::Validate()

    def model!(options, params:, **)
      options[:model] = UserEvent.find_by(event_id: params[:event_id], user_id: params[:user_id])
    end
  end
end

