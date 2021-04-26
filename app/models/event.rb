class Event < ApplicationRecord
  resourcify
  extend Enumerize

  enumerize :status, in: %i[open close], default: :open, predicates: true

  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events

  def bank
    val = user_events.sum(&:payment)
    val.zero? ? Money.new(0, 'RUB') : val
  end

  def admins
    users.with_role(:admin, self)
  end

  def required_payment
    return Money.new(0, 'RUB') if user_events.count.zero?

    Money.new(user_events.map(&:payment).sum / user_events.count, 'RUB')
  end
end
