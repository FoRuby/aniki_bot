class EventPolicy < ApplicationPolicy
  def close?
    admin? && opened?
  end

  def pay?
    member? && opened?
  end

  private

  def admin?
    record.admins.include? user
  end

  def member?
    record.users.include? user
  end

  def opened?
    record.open?
  end
end
