module Info::Operation::Response::Love
  class Success < Shared::Operation::Response::Success
    attr_reader :input

    def initialize(*args, input)
      super(*args)
      @input = input
    end

    def success_respond
      input.present? ? love : support
    end

    def love
      if input.include? '@GachiBuhgalterBot'
        bot.send_animation chat_id: chat_id, animation: image('predator_handshake.gif'), caption: 'Take it boy!'
      end

      input.map { |usertag| usertag[1..-1] }
           .map { |username| User.find_by_username(username) }
           .compact
           .each { |user| bot.send_message chat_id: user.chat_id, text: "#{current_user.tag} loves you!" }
    end

    def support
      bot.send_message text: love_quotes.sample, chat_id: chat_id, reply_to_message_id: message_id
    end

    def love_quotes
      [
        'You are the coolest!',
        "You're breathtaking!",
        'I love you!',
        'You will succeed!',
        'Do not be sad!',
        'You make me happier!',
        'God bless you!',
        'Shall we take a walk today?'
      ]
    end
  end
end
