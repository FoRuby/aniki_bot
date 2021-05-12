require 'rails_helper'

describe Info::Response::Say::Success, response: true do
  let(:current_user) { build_stubbed :user }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe '#success_respond' do
    subject { described_class.call(current_user, nil, payload) }
    it 'ANIKI should receive method call' do
      expect(ANIKI).to receive(:send_message)
      subject
    end
  end
end