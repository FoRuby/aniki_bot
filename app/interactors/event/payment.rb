class Event::Payment < BaseInteractor
  authorize :user

  attr_reader :user_event, :payment, :event, :user

  before :assign_attributes

  def call
    authorize
    pay_for_event
  end

  private

  def assign_attributes
    @event = context.event
    @user = context.user
    @user_event = UserEvent.find_by(event: event, user: user)
    @payment = context.payment
  end

  def pay_for_event
    user_event.update(payment: payment) ? success : fail
  end

  def authorize
    unathorized!(user) unless allowed_to? :pay?, event
  end

  def success
    context.user_event = user_event
  end

  def fail
    fail_interactor!(user_event.errors.full_messages)
  end
end