require 'rails_helper'

RSpec.describe Refill, type: :model do
  describe 'associations' do
    it { should belong_to(:debt) }
  end

  describe 'validations' do
    it do
      should enumerize(:status).in(:created, :completed)
                                    .with_default(:created)
                                    .with_predicates(true)
    end

    it { should monetize(:value) }
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