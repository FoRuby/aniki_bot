class UserEventPolicy < ApplicationPolicy
  def create?
    user
  end

  def edit?
    member?
  end

  def update?
    edit?
  end

  def delete?
    member? || admin?
  end

  private

  def member?
    model&.user == user
  end

  def admin?
    user&.has_role? :admin, model.event
  end
end
