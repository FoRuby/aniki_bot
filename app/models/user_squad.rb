class UserSquad < ApplicationRecord
  belongs_to :user
  belongs_to :squad

  validates_uniqueness_of :user_id, scope: %i[squad_id], message: "already in Squad, \u{2642} BOY \u{2642}"
end
