module EventsActions
  module Callbacks
    module KickSelect
      def kick_select_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          session[:event_id] = event_id.to_i
          session[:edit_event] = update.deep_symbolize_keys
          render = Render::Operation::UserKickSelect.call(event: operation[:model], current_user: current_user)
          render.success? ? respond_with(:message, render[:response]) : answer_callback_query(render[:response], show_alert: true)
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end
    end
  end
end

