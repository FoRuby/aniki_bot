module EventsController
  include EventsActions::Create
  include EventsActions::Show
  include EventsActions::Edit
  include EventsActions::Helper
end