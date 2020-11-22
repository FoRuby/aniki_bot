class Event::Create < BaseInteractor
  attr_reader :event_attributes, :event

  before :assign_attributes

  def call
    create_event
  end

  private

  def assign_attributes
    @event_attributes = {}
    @event_attributes[:name] = context.event_attributes.first
    @event_attributes[:date] = context.event_attributes[1..2]&.join(' ')
  end

  def create_event
    @event = Event.new(event_attributes)
    fail_interactor!(['Invalid Date format']) unless event_attributes[:date] =~ Event::DATE_FORMAT

    event.save ? success : fail
  end

  def success
    context.event = event
  end

  def fail
    fail_interactor!(event.errors.full_messages)
  end
end