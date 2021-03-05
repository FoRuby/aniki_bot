require 'rails_helper'

RSpec.describe Refill, type: :model do
  describe 'associations' do
    it { should belong_to(:from_user).class_name(User) }
    it { should belong_to(:to_user).class_name(User) }
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