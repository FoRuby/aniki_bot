module InfoActions::Start
  def start!(*)
    respond_with :message, text: t('.content')
  end
end