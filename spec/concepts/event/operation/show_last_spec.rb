require 'rails_helper'

RSpec.describe Event::Operation::ShowLast do
  before_all do
    @user = create :user
  end
  let(:user) { @user }

  subject(:operation) { described_class.call(current_user: user) }

  describe '.call' do
    describe 'valid params' do
      let!(:user_event) { create :user_event, user: user }

      it { should be_success }
      it { expect(operation[:model]).to eq user_event.event }
    end

    describe 'invalid params' do
      describe 'event does not exist' do
        it { should be_failure }
        it { expect(operation[:model]).to be_nil }
      end
    end
  end
end