class User < ApplicationRecord
  rolify

  has_many :feedbacks, dependent: :destroy

  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events

  has_many :user_creditors, foreign_key: :borrower_id, class_name: 'Debt'
  has_many :creditors, through: :user_creditors
  has_many :positive_creditors, -> { merge(Debt.positive) }, source: :creditor, through: :user_creditors

  has_many :user_borrowers, foreign_key: :creditor_id, class_name: 'Debt'
  has_many :borrowers, through: :user_borrowers
  has_many :positive_borrowers, -> { merge(Debt.positive) }, source: :borrower, through: :user_borrowers

  def tag
    return "@#{username}" if username

    first_name
  end

  def top_borrower
    user_borrowers.where(value_kopecks: user_borrowers.select('MAX(value_kopecks)')).first&.borrower
  end

  def top_creditor
    user_creditors.where(value_kopecks: user_creditors.select('MAX(value_kopecks)')).first&.creditor
  end

  def total_spend
    val = user_events.sum(&:payment)
    val = Money.new(0, 'RUB') if val.zero?
    val.format
  end

  def total_borrowed
    val = user_borrowers.sum(&:value)
    val = Money.new(0, 'RUB') if val.zero?
    val.format
  end

  def total_credited
    val = user_creditors.sum(&:value)
    val = Money.new(0, 'RUB') if val.zero?
    val.format
  end
end
