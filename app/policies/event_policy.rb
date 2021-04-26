class EventPolicy < ApplicationPolicy
  def show?
    user
  end

  def show_last?
    show?
  end

  def create?
    show?
  end

  def edit?
    update?
  end

  def update?
    admin? && member?
  end

  def close?
    update?
  end

  private

  def admin?
    user&.has_role? :admin, model
  end

  def member?
    model.users.include? user
  end
end
