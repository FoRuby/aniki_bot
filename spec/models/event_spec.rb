require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should have_many(:user_events).dependent(:destroy) }
    it { should have_many(:users).through(:user_events) }
  end

  describe 'validations' do
    it do
      should enumerize(:status).in(:open, :close)
                               .with_default(:open)
                               .with_predicates(true)
    end
  end

  describe 'delegators' do
  end

  describe 'nested attributes' do
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
    describe '#bank' do
      let(:event) { create :event }
      subject { event.bank }

      describe 'with empty payments' do
        let!(:user_events) { create_list :user_event, 2, event: event }
        it { should eq '0.00 ₽' }
      end

      describe 'with not empty payments' do
        let!(:user_events) { create_list :user_event, 2, event: event, payment: 150 }
        it { should eq '300.00 ₽' }
      end
    end
  end
end