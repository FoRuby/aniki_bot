module EventsActions
  module Show
    include EventsActions::Callbacks::Join
    include EventsActions::Callbacks::Leave
    include EventsActions::Callbacks::Bank
    include EventsActions::Callbacks::Pay
    include EventsActions::Callbacks::RefreshShow
    include EventsActions::Callbacks::Edit

    def event!(*args)
      operation = Event::Operation::Show.call(current_user: current_user, params: { id: args.first })
      if operation.success?
        response = Render::Operation::ShowEvent.call(event: operation[:model])[:response]
        respond_with :message, response
      else
        bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
      end
    end
  end
end
