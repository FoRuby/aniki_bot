class User < ApplicationRecord
  has_many :user_squads
  has_many :user_events
  has_many :notes

  has_many :user_payers, foreign_key: :user_id
  has_many :payers, through: :user_payers, source: :payer

  has_many :squads, through: :user_squads
  has_many :events, through: :user_events

  def usertag
    '@' + username
  end
end