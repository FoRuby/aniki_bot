module InfoActions::Love
  def love!(*args)
    args.present? ? send_love_to(args) : reply_with(:message, text: love_quotes.sample.to_s)
  end

  def send_love_to(users)
    users = users.map { |usertag| usertag[1..-1] }
                 .map { |username| User.find_by_username(username) }
                 .compact
    users.each do |user|
      bot.send_message chat_id: user.chat_id, text: "#{current_user.usertag} loves you!"
    end
  end

  def love_quotes
    [
      "Ты самый классный",
      "Я тебя люблю!",
      "У тебя все получится",
      "Не грусти",
      "Ты делаешь меня счастливей",
      "Храни тебя, Господь!",
      "Погуляем сегодня?"
    ]
  end
end