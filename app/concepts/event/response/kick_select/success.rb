module Event::Response::KickSelect
  class Success < Shared::Response::Success
    def success_respond
      respond_msg
    end

    def respond_msg
      @respond_msg ||=
        if operation[:model].users.where.not(id: current_user.id).present?
          bot.send_message(render.merge(chat_id: chat_id)).deep_symbolize_keys
        else
          bot.answer_callback_query callback_query_id: payload[:id],
                                    text: 'No users to kick out', show_alert: true
        end
    end

    def render
      Event::Render::KickSelect.call(event: operation[:model], current_user: current_user)
    end
  end
end
