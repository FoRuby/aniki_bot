class UserEvent < ApplicationRecord
  monetize :payment_kopecks, numericality: { greater_than_or_equal_to: 0 }, default: 0
  monetize :cost_kopecks, allow_nil: true, default: nil
  attribute :debt, class: Money

  belongs_to :user, inverse_of: :user_events
  belongs_to :event, inverse_of: :user_events
end
