require 'rails_helper'

describe User::Response::Refill::Success, response: true do
  before_all do
    @creditor = create :user, username: 'creditor'
    @borrower = create :user, username: 'borrower'
    @debt = create :debt, creditor: @creditor, borrower: @borrower, value: 100
    @refill = create :refill, debt: @debt, value: 100
  end
  let(:creditor) { @creditor }
  let(:borrower) { @borrower }
  let(:refill) { @refill }

  let(:current_user) { creditor }
  let(:operation) { Struct.new(:model, :refill).new(refill, refill) }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe '#success_respond' do
    before { allow(ANIKI).to receive(:send_message) }
    subject { described_class.call(current_user, operation, payload) }

    include_examples '#success_respond', :send_message do
      let(:params) do
        {
          text: 'Refill action between @creditor and @borrower complete. Refill sum = 100.00 ₽',
          chat_id: creditor.chat_id
        }
      end
    end

    include_examples '#success_respond', :send_message do
      let(:params) do
        {
          text: 'Refill action between @creditor and @borrower complete. Refill sum = 100.00 ₽',
          chat_id: borrower.chat_id
        }
      end
    end
  end

  describe '#message' do
    subject { described_class.new(current_user, operation, payload).message }
    let(:text) { 'Refill action between @creditor and @borrower complete. Refill sum = 100.00 ₽' }

    it { is_expected.to eq text }
  end
end