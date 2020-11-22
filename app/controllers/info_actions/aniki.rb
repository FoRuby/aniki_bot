module InfoActions::Aniki
  def aniki!(*)
    respond_with :photo, photo: image('aniki.jpg'), caption: t('.content')
  end
end