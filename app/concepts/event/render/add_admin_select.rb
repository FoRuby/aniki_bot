module Event::Render
  class AddAdminSelect < Event::Render::Base
    def render
      { text: text, parse_mode: 'html', reply_markup: reply_markup }
    end

    def text
      'Select a User to promote'
    end

    def reply_markup
      inline_keyboard = event.users.without_role(:admin, event).each_with_object([]) do |user, arr|
        arr << [{ text: user.tag, callback_data: "add_event_admin:#{user.id}" }]
      end
      { inline_keyboard: inline_keyboard }
    end
  end
end