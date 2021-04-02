module User::Response::RefillSelect
  class Success < Shared::Response::Success
    def success_respond
      respond_msg
    end

    def respond_msg
      @respond_msg ||=
        if render
          bot.send_message(render.merge(chat_id: chat_id)).deep_symbolize_keys
        else
          bot.answer_callback_query callback_query_id: payload[:id],
                                    text: 'You have not Borrowers', show_alert: true
        end
    end

    def render
      User::Render::RefillSelect.call(current_user: current_user)
    end
  end
end