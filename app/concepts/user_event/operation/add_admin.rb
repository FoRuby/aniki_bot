module UserEvent::Operation
  # UserEvent::Operation::AddAdmin.call(current_user: current_user, params: { event_id: event_id, user_id: user_id })
  class AddAdmin < Trailblazer::Operation
    step :model!
    step Policy::Pundit(UserEventPolicy, :add_admin?)
    step :assign_admin_role!

    def model!(options, params:, **)
      options[:model] = UserEvent.includes(:event).find_by(event_id: params[:event_id], user_id: params[:user_id])
    end

    def assign_admin_role!(options, model:, **)
      model.user.add_role(:admin, model.event)
    end
  end
end

