module Event::Operation::Render
  class KickSelect < Event::Operation::Render::Base
    def render
      @render ||= { text: text, parse_mode: 'html', reply_markup: reply_markup }
    end

    def text
      'Select a User to kick out'
    end

    def reply_markup
      inline_keyboard = event.users.where.not(id: current_user.id).each_with_object([]) do |user, arr|
        arr << [{ text: user.tag, callback_data: "kick:#{user.id}" }]
      end
      { inline_keyboard: inline_keyboard }
    end
  end
end