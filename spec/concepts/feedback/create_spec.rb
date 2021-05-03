require 'rails_helper'

RSpec.describe Feedback::Operation::Create do
  let(:user) { create :user }

  describe '.call' do
    subject(:operation) { described_class.call(params: params, current_user: user) }


    describe 'valid params' do
      before { allow(Feedback::Operation::Send).to receive(:call).and_return(true) }

      let(:user) { create :user }
      let(:params) { attributes_for :feedback }

      it { should be_success }
      it { expect { operation }.to change(Feedback, :count).by(1) }
    end

    describe 'invalid params' do
      describe 'nil user' do
        let(:user) { nil }
        let(:params) { attributes_for :feedback }

        it_behaves_like 'invalid create feedback operation'
        it { expect(operation['result.policy.default']).to be }
      end

      describe 'empty message' do
        let(:user) { create :user }
        let(:params) { attributes_for :feedback, :empty }

        it_behaves_like 'invalid create feedback operation'
        it { expect(operation_errors(operation)).to include 'Message must be filled' }
      end
    end
  end
end