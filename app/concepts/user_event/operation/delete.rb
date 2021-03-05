module UserEvent::Operation
  class Delete < Trailblazer::Operation
    step :model!
    step Policy::Pundit(UserEventPolicy, :delete?)
    step Contract::Build(constant: UserEvent::Contract::Delete)
    step Contract::Validate()
    step :delete!

    def model!(options, params:, **)
      options[:model] = UserEvent.find_by(event_id: params[:event_id], user_id: params[:user_id])
    end

    def delete!(options, model:, **)
      model.destroy
    end
  end
end

