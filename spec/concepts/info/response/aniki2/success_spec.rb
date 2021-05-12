require 'rails_helper'

describe Info::Response::Aniki2::Success, response: true do
  let(:current_user) { build_stubbed :user }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe '#success_respond' do
    let(:params) { { sticker: nil, chat_id: 'chat_id' } }
    before { allow(File).to receive(:open).and_return(nil) }
    subject { described_class.call(current_user, nil, payload) }

    it 'ANIKI should receive method call' do
      expect(ANIKI).to receive(:send_sticker).exactly(4).time
      subject
    end
  end
end