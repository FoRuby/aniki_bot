class UserPayer < ApplicationRecord
  belongs_to :user
  belongs_to :payer, class_name: 'User'
  monetize :debt_kopecks
end
