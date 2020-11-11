module InfoActions::Love
  def love!(*)
    reply_with :message, text: "#{quotes.sample}"
  end

  def quotes
    [
      "Ты самый классный",
      "Я тебя люблю!",
      "У тебя все получится",
      "Не грусти",
      "Ты делаешь меня счастливей",
      "Храни тебя, Господь!"
    ]
  end
end