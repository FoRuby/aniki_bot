module BaseController
  def current_user
    @current_user = User::Create.call(user_attributes: from).user
  end

  def image(name)
    File.open(File.join(Rails.root, 'app', 'assets', 'images', name), 'r')
  end

  # def render_errors(errors)
  #   errors.each { |m| "#{m}" }
  # end
end