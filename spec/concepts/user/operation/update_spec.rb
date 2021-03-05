require 'rails_helper'

RSpec.describe User::Operation::Update do
  subject(:operation) { described_class.call(params: params) }

  describe '.call' do
    let!(:user) { create :user }

    context 'valid params' do
      let(:params) { attributes_for :user, chat_id: user.chat_id }

      it { should be_success }
      it 'should change user attributes' do
        operation
        expect(operation[:model].first_name).to eq params[:first_name]
        expect(operation[:model].last_name).to eq params[:last_name]
        expect(operation[:model].username).to eq params[:username]
        expect(operation[:model].chat_id).to eq params[:chat_id]
      end
    end
  end
end