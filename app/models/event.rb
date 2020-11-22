class Event < ApplicationRecord
  extend Enumerize

  DATE_FORMAT = /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}(:\d{2})?\z/.freeze

  enumerize :status, in: %i[open close], default: :open, predicates: true

  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  has_many :admins, -> { merge(UserEvent.admins) }, source: :user, through: :user_events

  validates :date, :name, presence: true

  def admin
    user_events.find_by(admin: true)
  end
end
