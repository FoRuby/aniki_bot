require 'rails_helper'

RSpec.describe Feedback::Operation::Create do
  before_all do
    @user = create :user
  end
  let(:user) { @user }

  subject(:operation) { described_class.call(params: params, current_user: user) }

  describe '.call' do
    describe 'valid params' do
      before { allow(Feedback::Operation::Send).to receive(:call).and_return(true) }

      let(:params) { attributes_for :feedback, user: user }

      it { should be_success }
      it { expect { operation }.to change(Feedback, :count).by(1) }
      it { expect(operation[:model].user).to eq user }
    end

    describe 'invalid params' do
      describe 'nil user' do
        let(:user) { nil }
        let(:params) { attributes_for :feedback, user: user }

        it_behaves_like 'invalid create feedback operation'
        it { expect(operation['result.policy.default']).to be }
      end

      describe 'empty message' do
        let(:params) { attributes_for :feedback, :empty, user: user }

        it_behaves_like 'invalid create feedback operation'
        it { expect(operation_errors(operation)).to include 'Message must be filled' }
      end
    end
  end
end