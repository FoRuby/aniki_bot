class Debt < ApplicationRecord
  belongs_to :creditor, class_name: 'User'
  belongs_to :borrower, class_name: 'User'

  monetize :debt_kopecks, default: 0
end
