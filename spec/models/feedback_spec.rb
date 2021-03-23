require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
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
