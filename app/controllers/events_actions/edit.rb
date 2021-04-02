module EventsActions
  module Edit
    include EventsActions::Callbacks::Close
    include EventsActions::Callbacks::Update
    include EventsActions::Callbacks::KickSelect
    include EventsActions::Callbacks::Kick
  end
end
