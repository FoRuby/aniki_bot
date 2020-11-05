module InfoActions::Aniki2
  def aniki2!(*)
    (1..4).each { |i| respond_with :sticker, sticker: image("aniki#{i}.webp") }
  end
end