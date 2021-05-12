require 'rails_helper'

RSpec.describe Event::Operation::Close do
  before_all do
    @admin = create :user
    @user1 = create_default :user
    @user2 = create_default :user
    @event = create :event, :with_admin, user: @admin
  end
  let(:admin) { @admin }
  let(:user1) { @user1 }
  let(:user2) { @user2 }
  let(:event) { @event }
  let(:default_params) { attributes_for :event }

  subject(:operation) { described_class.call(params: params, current_user: user) }

  describe '.call' do
    let(:params) { { id: event.id } }
    let(:user) { admin }

    describe 'valid params' do
      describe '2 event members' do
        before { create :user_event, event: event, user: user1, payment: 300 }

        it_behaves_like 'success close event operation', debt_count: 1, refill_count: 1
        it { expect(operation[:debts].map(&:value).map(&:format).sort).to match_array ['150.00 ₽'] }
      end

      describe '3 event members' do
        before do
          create :user_event, event: event, user: user1, payment: 100
          create :user_event, event: event, user: user2, payment: 200
        end

        it_behaves_like 'success close event operation', debt_count: 1, refill_count: 1
        it { expect(operation[:debts].map(&:value).map(&:format).sort).to match_array ['100.00 ₽'] }
      end

      describe '3 event members' do
        before do
          create :user_event, event: event, user: user1, payment: 50
          create :user_event, event: event, user: user2, payment: 250
        end

        it_behaves_like 'success close event operation', debt_count: 2, refill_count: 2
        it { expect(operation[:debts].map(&:value).map(&:format).sort).to match_array ['100.00 ₽', '50.00 ₽'] }
      end
    end

    describe 'invalid params' do
      describe 'event does not exist' do
        let(:params) { { id: 1234 } }

        it_behaves_like 'invalid close event operation'
      end

      describe 'not admin user' do
        let(:user) { user1 }

        it_behaves_like 'invalid close event operation'
      end

      describe 'closed event' do
        let!(:event) { create :event, :close, :with_admin, user: admin }

        it_behaves_like 'invalid close event operation'
        it { expect(operation_errors(operation)).to include 'Event is already close' }
      end
    end
  end
end