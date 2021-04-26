module Event::Response::Update::Description
  class Success < Shared::Response::Success
    def success_respond
      bot.send_message chat_id: chat_id, text: I18n.t('telegram_webhooks.update_event_description.success')
    end

    def render_edit
      Event::Render::Edit.call(event: model, current_user: current_user)
    end
  end
end
