module InfoActions::Pants
  def pants!(*)
    respond_with :animation, animation: image("pants.mp4")
  end
end