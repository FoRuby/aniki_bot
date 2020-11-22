class Event::Find < BaseInteractor
  attr_reader :event_id, :event

  before :assign_attributes

  def call
    find_event
  end

  private

  def assign_attributes
    @event_id = context.event_id.to_i
  end

  def find_event
    @event = Event.find_by(id: event_id)

    event ? success : fail
  end

  def success
    context.event = event
  end

  def fail
    fail_interactor!(["Couldn't find Event with 'id'=#{context.event_id}'"])
  end
end