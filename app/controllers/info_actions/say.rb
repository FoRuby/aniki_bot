module InfoActions::Say
  def say!(*)
    respond_with :message, text: "\u{2642} #{quotes.sample} \u{2642}"
  end

  def quotes
    [
      "Our daddy taught us not to be ashamed of our dicks",
      "THANK YOU, SIR!",
      "OH SHIT, I'M SORRY!",
      "FISTING IS 300$",
      "ASS WE CAN",
      "Come on college boy",
      "Oh my shoulder",
      "Pull up your pants",
      "That's power son, that's power",
      "It gets bigger when I pull on",
      "Boy next door",
      "Do you like what you see?",
      "Take it boy!",
      "Fuck you leather man!"
    ]
  end
end