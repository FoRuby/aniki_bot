module EventsActions
  module Callbacks
    module RefreshEdit
      def refresh_edit_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          response = Render::Operation::EditEvent.call(event: operation[:model])[:response]
          edit_message :text, response
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      rescue Telegram::Bot::Error => e
        puts "Rescued: #{e.inspect}"
      end
    end
  end
end