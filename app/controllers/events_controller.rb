module EventsController
  include EventsActions::Create
  include EventsActions::Show
  include EventsActions::ShowLast
  include EventsActions::Edit
end