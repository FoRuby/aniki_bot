require 'rails_helper'

RSpec.describe UserEvent, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end

  describe 'validations' do
    it { should monetize(:payment) }
    it { should monetize(:cost) }
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