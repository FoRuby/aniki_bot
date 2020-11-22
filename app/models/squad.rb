class Squad < ApplicationRecord
  has_many :user_squads
  has_many :users, through: :user_squads

  validates :name, presence: true, uniqueness: true
end
