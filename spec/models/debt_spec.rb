require 'rails_helper'

RSpec.describe Debt, type: :model do
  describe 'associations' do
    it { should belong_to(:creditor).class_name(User) }
    it { should belong_to(:borrower).class_name(User) }
  end

  describe 'validations' do
    it { should monetize(:debt) }
  end

  describe 'delegators' do
  end

  describe 'nested attributes' do
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end