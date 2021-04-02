module EventsActions
  module Callbacks
    module Update
      def update_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          save_context :update_event
          session[:event_id] = operation[:model].id
          session[:edit_event] = payload.deep_symbolize_keys
          bot.send_message chat_id: current_user.chat_id, text: t('telegram_webhooks.update_callback_query.success')
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end

      def update_event(*args)
        return unless current_user.chat_id == payload['chat']['id']

        params = Event::Parser::Base.call(args).merge(id: session[:event_id])
        operation = Event::Operation::Update.call(current_user: current_user, params: params)
        if operation.success?
          Event::Operation::Response::Update::Success.call(
            payload: payload, current_user: current_user, operation: operation,
            session_payload: { edit_event: session[:edit_event], show_event: session[:show_event] }
          )
        else
          Event::Operation::Response::Update::Failure.call(payload: payload, current_user: current_user, operation: operation)
        end
      end
    end
  end
end