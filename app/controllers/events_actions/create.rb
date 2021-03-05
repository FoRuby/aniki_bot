module EventsActions::Create
  def create_event!(*args)
    params = Event::Parser::Base.call(args)
    operation = Event::Operation::Create.call(current_user: current_user, params: params)

    if operation.success?
      render_event operation[:model]
    else
      bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
    end
  end
end