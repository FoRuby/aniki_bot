module EventsActions
  module Edit
    include EventsActions::Callbacks::Close
    include EventsActions::Callbacks::Update
    include EventsActions::Callbacks::Kick
    include EventsActions::Callbacks::KickSelect
    include EventsActions::Callbacks::AddAdmin
    include EventsActions::Callbacks::AddAdminSelect
    include EventsActions::Callbacks::Description
  end
end
