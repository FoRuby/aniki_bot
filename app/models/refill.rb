class Refill < ApplicationRecord
  extend Enumerize

  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  enumerize :status, in: %i[created completed], default: :created, predicates: true
  monetize :value_kopecks, numericality: { greater_than_or_equal_to: 0 }, default: 0
end
