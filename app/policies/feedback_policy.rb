class FeedbackPolicy < ApplicationPolicy
  def create?
    user
  end
end
