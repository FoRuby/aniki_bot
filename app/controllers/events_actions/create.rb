module EventsActions
  module Create
    def create_event!(*args)
      operation = Event::Operation::Create.call(current_user: current_user, params: Event::Parser::Base.call(args))
      if operation.success?
        response = Render::Operation::ShowEvent.call(event: operation[:model])[:response]
        respond_with :message, response
      else
        bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
      end
    end
  end
end