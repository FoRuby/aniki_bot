class Event::DeleteUser < BaseInteractor
  attr_reader :event, :user, :user_event

  before :assign_attributes

  def call
    delete_user_from_event
  end

  private

  def assign_attributes
    @event = context.event
    @user = context.user
  end

  def delete_user_from_event
    @user_event = UserEvent.find_by(event: context.event, user: context.user)

    user_event ? success : fail
  end

  def success
    context.user_event = user_event.destroy
  end

  def fail
    fail_interactor!(['You are not participating in the event'])
  end
end