module User::Response::CompensationSelect
  class Success < Shared::Response::Success
    def success_respond
      if render
        bot.send_message(render.merge(chat_id: chat_id))
      else
        bot.answer_callback_query callback_query_id: payload[:id],
                                  text: I18n.t('telegram_webhooks.compensation_select_callback_query.failure'),
                                  show_alert: true
      end
    end

    def render
      @render ||= User::Render::CompensationSelect.call(current_user: current_user)
    end
  end
end