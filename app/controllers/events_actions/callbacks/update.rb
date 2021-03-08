module EventsActions
  module Callbacks
    module Update
      def update_callback_query(event_id = nil, *)
        operation = Event::Operation::Edit.call(current_user: current_user, params: { id: event_id })
        if operation.success?
          session[:event_id] = operation[:model].id
          save_context :update_event
          bot.send_message chat_id: current_user.chat_id, text: t('telegram_webhooks.update_callback_query.success'), alert: true
        else
          answer_callback_query(render_errors(operation), show_alert: true)
        end
      end

      def update_event(*args)
        return unless current_user.chat_id == payload['chat']['id']

        params = Event::Parser::Base.call(args).merge(id: session[:event_id])
        operation = Event::Operation::Update.call(current_user: current_user, params: params)
        if operation.success?
          response = Render::Operation::EditEvent.call(current_user: current_user, event: operation[:model])[:response]
          respond_with :message, response
        else
          bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
        end
      end
    end
  end
end