module EventsActions
  module Callbacks
    module Description
      def description_event_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          save_context :update_event_description
          session[:event_id] = operation[:model].id
          session[:edit_event] = payload.deep_symbolize_keys
          bot.send_message chat_id: current_user.chat_id, text: t('telegram_webhooks.description_callback_query.success')
        else
          Shared::Response::Failure.call(current_user, operation, payload, callback: true)
        end
      end

      def update_event_description(*args)
        return unless current_user.chat_id == payload['chat']['id']

        params = Event::Parser::Description.call(payload).merge(id: session[:event_id])
        operation = Event::Operation::Update.call(current_user: current_user, params: params)
        if operation.success?
          Event::Response::Update::Description::Success.call(current_user, operation, payload)
        else
          Shared::Response::Failure.call(current_user, operation, payload)
        end
      end
    end
  end
end