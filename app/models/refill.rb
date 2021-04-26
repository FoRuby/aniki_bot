class Refill < ApplicationRecord
  extend Enumerize

  enumerize :status, in: %i[created completed rollback], default: :created, predicates: true
  monetize :value_kopecks

  belongs_to :debt

  delegate :borrower, :creditor, to: :debt
end
