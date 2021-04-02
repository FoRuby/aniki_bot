class Refill < ApplicationRecord
  extend Enumerize

  enumerize :status, in: %i[created completed], default: :created, predicates: true
  monetize :value_kopecks, numericality: { greater_than_or_equal_to: 0 }, default: 0

  belongs_to :debt

  delegate :borrower, :creditor, to: :debt
end
