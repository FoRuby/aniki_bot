module InfoActions::Van
  def van!(*)
    respond_with :photo, photo: image('van.jpg'), caption: t('.content')
  end
end