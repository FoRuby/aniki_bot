module EventsActions
  module Create
    def create_event!(*args)
      operation = Event::Operation::Create.call(current_user: current_user, params: Event::Parser::Base.call(args))
      if operation.success?
        response = Render::Operation::ShowEvent.call(event: operation[:model])[:response]
        respond = respond_with(:message, response).deep_symbolize_keys
        return if respond.dig(:result, :chat, :type) != 'supergroup'

        bot.pin_chat_message(chat_id: respond.dig(:result, :chat, :id), message_id: respond.dig(:result, :message_id))
      else
        bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
      end
    end
  end
end