require 'rails_helper'

RSpec.describe User::Operation::Create do
  subject(:operation) { described_class.call(params: params) }

  describe '.call' do
    context 'valid params' do
      let(:params) { attributes_for :user }

      it { should be_success }
      it { expect { operation }.to change(User, :count).by(1) }
    end

    context 'invalid params' do
      let!(:user) { create :user }
      let(:params) { attributes_for :user, chat_id: user.chat_id }

      it { should be_failure }

      it 'should contain errors' do
        expect(operation_errors(operation)).to include 'Chat Id is already exist'
      end
    end
  end
end