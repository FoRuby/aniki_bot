module EventsActions
  module ShowLast
    include EventsActions::Callbacks::Join
    include EventsActions::Callbacks::Leave
    include EventsActions::Callbacks::Bank
    include EventsActions::Callbacks::Pay
    include EventsActions::Callbacks::RefreshShow
    include EventsActions::Callbacks::Edit

    def last_event!(*args)
      operation = Event::Operation::ShowLast.call(current_user: current_user)
      if operation.success?
        response = Render::Operation::ShowEvent.call(event: operation[:model])[:response]
        respond_with :message, response
      else
        bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
      end
    end
  end
end
