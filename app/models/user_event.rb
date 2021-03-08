class UserEvent < ApplicationRecord
  monetize :payment_kopecks, numericality: { greater_than_or_equal_to: 0 }, default: 0
  monetize :debt_kopecks, default: 0

  scope :majors, -> { where('debt_kopecks > 0') }
  scope :minors, -> { where.not('debt_kopecks > 0') }
  scope :admins, -> { where(admin: true) }

  belongs_to :user, inverse_of: :user_events
  belongs_to :event, inverse_of: :user_events
end
