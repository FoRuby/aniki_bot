module Info::Response::Love
  class Success < Shared::Response::Success
    LOVE_QUOTES =
      [
        'You are the coolest!',
        "You're breathtaking!",
        'I love you!',
        'You will succeed!',
        'Do not be sad!',
        'You make me happier!',
        'God bless you!',
        'Shall we take a walk today?'
      ].freeze

    attr_reader :input

    def initialize(*args, input)
      super(*args)
      @input = input
    end

    def success_respond
      input.present? ? love : support
    end

    def love
      User.where(username: input.map { |username| username[1..] }).each do |user|
        user.username == bot.username ? love_to_aniki : love_to(user)
      end
    end

    def love_to_aniki
      bot.send_animation chat_id: current_user.chat_id, animation: image('predator_handshake.gif'), caption: 'Take it boy!'
    end

    def love_to(user)
      bot.send_message chat_id: user.chat_id, text: "#{current_user.tag} loves you!"
    end

    def support
      bot.send_message text: LOVE_QUOTES.sample, chat_id: chat_id, reply_to_message_id: message_id
    end
  end
end
