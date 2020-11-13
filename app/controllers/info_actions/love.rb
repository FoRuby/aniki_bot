module InfoActions::Love
  def love!(*)
    reply_with :message, text: love_quotes.sample.to_s
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