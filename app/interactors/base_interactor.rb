class BaseInteractor
  include Interactor
  include ActionPolicy::Behaviour

  def unathorized!(user)
    fail_interactor!(["User #{user.usertag} unathorized to perform this action"])
  end

  def fail_interactor!(errors_arr)
    context.errors = errors_arr
    context.fail!
  end
end