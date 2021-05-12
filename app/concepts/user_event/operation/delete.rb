module UserEvent::Operation
  # UserEvent::Operation::Вудуеу.call(current_user: current_user, params: { event_id: event_id, user_id: user_id })
  class Delete < Trailblazer::Operation
    step :model!
    step Policy::Pundit(UserEventPolicy, :delete?)
    step Contract::Build(constant: UserEvent::Contract::Delete)
    step Contract::Validate()
    step :assign_event!
    step :assign_user!
    step :dismiss_admin_role!
    step :delete!

    def model!(options, params:, **)
      options[:model] = UserEvent.includes(:event)
                                 .find_by(event_id: params[:event_id], user_id: params[:user_id])
    end

    def assign_event!(options, model:, **)
      options[:event] = model.event
    end

    def assign_user!(options, model:, **)
      options[:user] = model.user
    end

    def dismiss_admin_role!(options, user:, event:, **)
      condition = event.admins.include?(user) && event.admins.count >= 2
      condition ? user.remove_role(:admin, event) : true
    end

    def delete!(options, model:, **)
      model.destroy
    end
  end
end

