module InfoActions::Aniki3
  def aniki3!(*)
    respond_with :photo, photo: image('aniki3.jpg')
  end
end