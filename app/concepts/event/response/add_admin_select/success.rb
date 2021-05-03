module Event::Response::AddAdminSelect
  class Success < Shared::Response::Success
    def success_respond
      if model.users.without_role(:admin, model).present?
        bot.send_message(render.merge(chat_id: chat_id)).deep_symbolize_keys
      else
        bot.answer_callback_query callback_query_id: payload[:id],
                                  text: 'No users to promote', show_alert: true
      end
    end

    def render
      Event::Render::AddAdminSelect.call(event: model, current_user: current_user)
    end
  end
end
