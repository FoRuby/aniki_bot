class EventPolicy < ApplicationPolicy
  def show?
    member?
  end

  def show_last?
    show?
  end

  def create?
    user
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end

  def close?
    admin?
  end

  private

  def admin?
    user&.has_role? :admin, model
  end

  def member?
    model.users.include? user
  end
end
