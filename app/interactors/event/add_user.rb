class Event::AddUser < BaseInteractor
  attr_reader :event, :user, :user_event

  before :assign_attributes

  def call
    add_user_to_event
  end

  private

  def assign_attributes
    @event = context.event
    @user = context.user
  end

  def add_user_to_event
    @user_event = UserEvent.new(event: context.event, user: context.user)

    user_event.save ? success : fail
  end

  def success
    context.user_event = user_event
  end

  def fail
    fail_interactor!(user_event.errors.full_messages)
  end
end