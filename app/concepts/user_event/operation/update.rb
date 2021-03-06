module UserEvent::Operation
  # UserEvent::Operation::Update.call(current_user: current_user,
  #   params: { user_id: user_id, event_id: event_id, payment: payment }
  # )
  class Update < Trailblazer::Operation
    step :model!
    step Policy::Pundit(UserEventPolicy, :update?)
    step Contract::Build(constant: UserEvent::Contract::Update, builder: :default_contract!)
    step Contract::Validate()
    step Contract::Persist()

    def model!(options, params:, **)
      options[:model] = UserEvent.find_by(event_id: params[:event_id], user_id: params[:user_id])
    end

    def default_contract!(options, constant:, model:, **)
      constant.new(model, user_event: model)
    end
  end
end