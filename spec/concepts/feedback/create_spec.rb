require 'rails_helper'

RSpec.describe Feedback::Operation::Create do
  let(:user) { create :user }

  describe '.call' do
    subject(:operation) { described_class.call(params: params, current_user: user) }

    describe 'valid params' do
      let(:user) { create :user }
      let(:params) { { message: Faker::Books::Lovecraft.paragraph } }

      it { should be_success }
      it { expect { operation }.to change(Feedback, :count).by(1) }
    end

    describe 'invalid params' do
      describe 'nil user' do
        let(:user) { nil }
        let(:params) { { message: Faker::Books::Lovecraft.paragraph } }

        it_behaves_like 'invalid create feedback operation'
        it { expect(operation[:"result.policy.default"]).to be }
      end

      describe 'empty message' do
        let(:user) { create :user }
        let(:params) { { message: '' } }

        it_behaves_like 'invalid create feedback operation'
        it { expect(operation_errors(operation)).to include 'Message must be filled' }
      end
    end
  end
end