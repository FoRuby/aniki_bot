require 'rails_helper'

RSpec.describe Feedback::Operation::Send do
  before_all do
    @user = create :user, username: 'foo'
    @admin = create :user, username: 'r1zrei'
    @feedback = create :feedback, user: @user
  end
  let(:user) { @user }
  let(:admin) { @admin }
  let(:feedback) { @feedback }
  let(:text) { "From user: @foo\n#{feedback.message}" }

  subject(:operation) { described_class.call(feedback: feedback, current_user: user) }

  describe '.call' do
    describe 'valid params' do
      before { allow(ANIKI).to receive(:send_message).with(chat_id: admin.chat_id, text: text).and_return(true) }

      it { should be_success }
      it { expect(operation[:model]).to eq feedback }
    end
  end
end