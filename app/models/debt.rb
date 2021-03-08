class Debt < ApplicationRecord
  monetize :value_kopecks, default: 0

  belongs_to :creditor, class_name: 'User'
  belongs_to :borrower, class_name: 'User'
  has_many :refills

  scope :positive, -> { where('value_kopecks > 0') }
end
