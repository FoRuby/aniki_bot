require 'rails_helper'

describe User::Response::Compensation::Failure, response: true do
  before_all do
    @creditor = create :user, username: 'creditor'
    @borrower = create :user, username: 'borrower'
  end
  let(:creditor) { @creditor }
  let(:borrower) { @borrower }
  let(:compensation) { Money.new(100_00, 'RUB') }

  let(:current_user) { creditor }
  let(:operation) { Struct.new(:opponent, :compensation).new(borrower, compensation) }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe '#success_respond' do
    before { allow(ANIKI).to receive(:send_message) }
    subject { described_class.call(current_user, operation, payload) }

    include_examples '#success_respond', :send_message do
      let(:params) do
        {
          text: 'Sending message to @borrower to complete action',
          chat_id: creditor.chat_id
        }
      end
    end

    describe '#success_respond' do
      include_examples '#success_respond', :send_message do
        let(:params) { { text: 'text', chat_id: 'chat_id', parse_mode: 'html', reply_markup: 'reply_markup' } }
        before { allow(Shared::Render::Confirmation).to receive(:call).and_return(params) }
        subject { described_class.call(current_user, operation, payload) }
      end
    end
  end

  describe '#user_message' do
    subject { described_class.new(current_user, operation, payload).user_message }
    let(:text) { 'Sending message to @borrower to complete action' }

    it { is_expected.to eq text }
  end

  describe 'render Shared::Render::Confirmation' do
    include_examples '#render' do
      let(:params) do
        {
          text: 'User @creditor trying to compensate 100.00 ₽. Select Yes to complete action',
          current_user: borrower,
          positive_callback: { callback_data: "compensation:#{creditor.id}" }
        }
      end
      let(:render) { Shared::Render::Confirmation }
      subject { described_class.new(current_user, operation, payload).opponent_render }
    end
  end
end