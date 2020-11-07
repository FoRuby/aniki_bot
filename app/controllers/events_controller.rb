module EventsController
  include EventActions::Helper
  include EventActions::CreateEvent
  # include EventActions::JoinEvent
  # include EventActions::EventPayment
  include EventActions::CloseEvent
  # include EventActions::EventInfo
  include EventActions::Event
  # include EventActions::EventBank
end