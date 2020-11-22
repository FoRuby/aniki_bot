class Event::SetAdmin < BaseInteractor
  def call
    set_admin_to_user_event
  end

  private

  def set_admin_to_user_event
    context.user_event.update(admin: true)
  end
end