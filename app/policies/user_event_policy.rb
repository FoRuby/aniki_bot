class UserEventPolicy < ApplicationPolicy
  def create?
    user
  end

  def edit?
    own_record?
  end

  def update?
    edit?
  end

  def delete?
    member? || admin?
  end

  def add_admin?
    member? && admin?
  end

  private

  def member?
    model.event.users.include? user
  end

  def own_record?
    model&.user == user
  end

  def admin?
    user&.has_role? :admin, model.event
  end
end
