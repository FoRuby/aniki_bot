require 'rails_helper'

describe User::Response::Compensation::Success, response: true do
  before_all do
    @creditor = create :user, username: 'creditor'
    @borrower = create :user, username: 'borrower'
    @debt = create :debt, creditor: @creditor, borrower: @borrower, value: 100
    @refill = create :refill, debt: @debt, value: 100
  end
  let(:creditor) { @creditor }
  let(:borrower) { @borrower }
  let(:compensation) { Money.new(100_00, 'RUB') }
  let(:debt) { @debt }
  let(:refill) { @refill }

  let(:current_user) { creditor }
  let(:operation) { Struct.new(:model, :refill, :opponent, :compensation).new(debt, refill, borrower, compensation) }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe '#success_respond' do
    before { allow(ANIKI).to receive(:send_message) }
    subject { described_class.call(current_user, operation, payload) }

    include_examples '#success_respond', :send_message do
      let(:params) do
        {
          text: 'Compensation action between @creditor and @borrower complete. Compensation sum = 100.00 ₽',
          chat_id: creditor.chat_id
        }
      end
    end

    include_examples '#success_respond', :send_message do
      let(:params) do
        {
          text: 'Compensation action between @creditor and @borrower complete. Compensation sum = 100.00 ₽',
          chat_id: borrower.chat_id
        }
      end
    end
  end

  describe '#message' do
    subject { described_class.new(current_user, operation, payload).message }
    let(:text) { 'Compensation action between @creditor and @borrower complete. Compensation sum = 100.00 ₽' }

    it { is_expected.to eq text }
  end
end