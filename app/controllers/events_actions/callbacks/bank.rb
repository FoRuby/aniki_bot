module EventsActions
  module Callbacks
    module Bank
      def bank_callback_query(event_id = nil, *)
        operation = Event::Operation::Show.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          response = Render::Operation::ShowEvent.call(event: operation[:model])[:bank]
          bot.send_message chat_id: current_user.chat_id, text: response, parse_mode: 'html'
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end
    end
  end
end