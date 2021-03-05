class Event < ApplicationRecord
  resourcify
  extend Enumerize

  enumerize :status, in: %i[open close], default: :open, predicates: true

  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events

  def bank
    val = user_events.sum(&:payment)
    val = Money.new(0, 'RUB') if val.zero?
    val.format
  end
end
