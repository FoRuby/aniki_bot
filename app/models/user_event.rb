class UserEvent < ApplicationRecord
  monetize :payment_kopecks, numericality: { greater_than_or_equal_to: 0 }

  monetize :debt_kopecks

  scope :major, -> { where('debt_kopecks > 0') }
  scope :minor, -> { where.not('debt_kopecks > 0') }
  scope :admins, -> { where(admin: true) }

  belongs_to :user
  belongs_to :event

  validates_uniqueness_of :user_id, scope: %i[event_id], message: 'is already involved in the event'
end
