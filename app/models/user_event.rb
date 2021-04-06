class UserEvent < ApplicationRecord
  monetize :payment_kopecks, numericality: { greater_than_or_equal_to: 0 }, default: 0
  monetize :cost_kopecks, default: 0
  attribute :debt, class: Money

  belongs_to :user, inverse_of: :user_events
  belongs_to :event, inverse_of: :user_events
end
