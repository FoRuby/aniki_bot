module EventsActions
  module Callbacks
    module Update
      def update_event_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          save_context :update_event
          session[:event_id] = operation[:model].id
          session[:edit_event] = payload.deep_symbolize_keys
          bot.send_message chat_id: current_user.chat_id, text: t('telegram_webhooks.update_callback_query.success')
        else
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end

      def update_event(*args)
        return unless current_user.chat_id == payload['chat']['id']

        params = Event::Parser::Update.call(args).merge(id: session[:event_id])
        operation = Event::Operation::Update.call(current_user: current_user, params: params)
        if operation.success?
          Event::Response::Update::Success.call(
            current_user, operation, payload,
            session_payload: { edit_event: session[:edit_event], show_event: session[:show_event] }
          )
        else
          Shared::Response::Failure.call(current_user, operation, payload)
        end
      end
    end
  end
end