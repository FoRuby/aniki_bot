module InfoActions
  module Love
    def love!(*args)
      args.present? ? send_love_to(args) : reply_with(:message, text: love_quotes.sample.to_s)
    end

    def send_love_to(users)
      if users.include? '@GachiBuhgalterBot'
        bot.send_animation chat_id: current_user.chat_id,
                           animation: image('predator_handshake.gif'),
                           caption: 'Take it boy!'
      end

      users = users.map { |usertag| usertag[1..-1] }
                   .map { |username| User.find_by_username(username) }
                   .compact
      users.each do |user|
        bot.send_message chat_id: user.chat_id, text: "#{current_user.tag} loves you!"
      end
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