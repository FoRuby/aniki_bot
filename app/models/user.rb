class User < ApplicationRecord
  rolify

  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events

  has_many :user_creditors, foreign_key: :borrower_id, class_name: 'Debt'
  has_many :creditors, through: :user_creditors

  has_many :user_borrowers, foreign_key: :creditor_id, class_name: 'Debt'
  has_many :borrowers, through: :user_borrowers

  has_many :refills, foreign_key: :to_user_id, class_name: 'Refill'
  has_many :notes, dependent: :nullify

  def tag
    return "@#{username}" if username

    first_name
  end

  def top_borrower
    user_borrowers.where(debt_kopecks: user_borrowers.select('MAX(debt_kopecks)')).first&.borrower
  end

  def top_creditor
    user_creditors.where(debt_kopecks: user_creditors.select('MAX(debt_kopecks)')).first&.creditor
  end

  def total_spend
    val = user_events.sum(&:payment)
    val = Money.new(0, 'RUB') if val.zero?
    val.format
  end

  def total_borrowed
    val = user_borrowers.sum(&:debt)
    val = Money.new(0, 'RUB') if val.zero?
    val.format
  end

  def total_credited
    val = user_creditors.sum(&:debt)
    val = Money.new(0, 'RUB') if val.zero?
    val.format
  end
end
