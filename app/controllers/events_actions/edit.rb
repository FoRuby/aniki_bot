module EventsActions
  module Edit
    include EventsActions::Callbacks::Close
    include EventsActions::Callbacks::Update
    include EventsActions::Callbacks::KickSelect
    include EventsActions::Callbacks::Kick
    include EventsActions::Callbacks::RefreshEdit
  end
end
