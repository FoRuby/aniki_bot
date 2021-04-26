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
    describe '#info' do
      let(:event) { create :event }
      subject { event.bank.format }

      describe 'with empty payments' do
        let!(:user_events) { create_list :user_event, 2, event: event }
        it { should eq '0.00 ₽' }
      end

      describe 'with not empty payments' do
        let!(:user_events) { create_list :user_event, 2, event: event, payment: 150 }
        it { should eq '300.00 ₽' }
      end
    end

    describe '#admins' do
      let(:event) { create :event }
      subject { event.admins }

      describe 'with admins' do
        let(:user_events) { create_list :user_event, 2, event: event }

        before { user_events.each { |user_event| user_event.user.add_role(:admin, user_event.event) } }

        it { should match_array user_events.map(&:user) }
      end

      describe 'without admins' do
        let(:user_events) { create_list :user_event, 2, event: event }

        it { should be_empty }
      end
    end

    describe '#required_payment' do
      let(:event) { create :event }
      subject { event.required_payment }

      describe 'Event' do
        describe 'with one user' do
          let!(:user_event) { create :user_event, event: event, payment: 300 }

          it { should eq Money.new(300_00, 'RUB') }
        end

        describe 'with two users' do
          let!(:user_event1) { create :user_event, event: event, payment: 300 }
          let!(:user_event2) { create :user_event, event: event }

          it { should eq Money.new(150_00, 'RUB') }
        end

        describe 'without users' do
          it { should eq Money.new(0, 'RUB') }
        end
      end
    end
  end
end