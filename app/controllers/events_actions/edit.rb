module EventsActions::Edit
  include EventsActions::Callbacks::Close
  include EventsActions::Callbacks::Update
  include EventsActions::Callbacks::KickSelect
  include EventsActions::Callbacks::Kick
  include EventsActions::Callbacks::RefreshEdit

  def edit_event!(*args)
    operation = Event::Operation::Edit.call(current_user: current_user, params: { id: args.first })
    if operation.success?
      render_edit_event operation[:model]
    else
      bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
    end
  end
end
