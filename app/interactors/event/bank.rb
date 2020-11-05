class Event::Bank < BaseInteractor
  attr_reader :event, :user_events

  before :assign_attributes

  def call
    bank
  end

  private

  def assign_attributes
    @event = context.event
    @user_events = event.user_events
  end

  def bank
    fail_interactor!(['No one participates in the event']) if user_events.blank?
    context.user_events = user_events.includes(:user)
  end
end