class Event::Debt < BaseInteractor
  authorize :user
  attr_reader :event, :user_events, :user

  before :assign_attributes

  def call
    authorize
    debt
    close_event
  end

  private

  def assign_attributes
    @event = context.event
    @user_events = event.user_events.includes(:user)
    @user = context.user
  end

  def authorize
    unathorized!(user) unless allowed_to? :close?, event
  end

  def debt
    user_events.each { |i| i.update(debt: i.payment - cost) }
  end

  def cost
    @cost ||= event_bank / user_event_count
  end

  def event_bank
    @event_bank ||= user_events.map(&:payment).sum
  end

  def user_event_count
    @user_event_count ||= user_events.count
  end

  def close_event
    event.update(status: :close)
  end
end


