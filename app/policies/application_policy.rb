class ApplicationPolicy < ActionPolicy::Base
  attr_reader :model, :user

  def initialize(user, model)
    @user, @model = user, model
  end
end
