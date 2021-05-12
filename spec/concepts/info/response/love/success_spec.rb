require 'rails_helper'

describe Info::Response::Love::Success, response: true do
  let(:current_user) { build_stubbed :user }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe '#love_to_aniki' do
    include_examples '#success_respond', :send_animation do
      let(:params) { { animation: nil, chat_id: current_user.chat_id, caption: 'Take it boy!' } }
      before { allow(File).to receive(:open).and_return(nil) }
      subject { described_class.new(current_user, nil, payload, 'test').love_to_aniki }
    end
  end

  describe '#love_to(user)' do
    include_examples '#success_respond', :send_message do
      let(:user) { build_stubbed :user }
      let(:params) { { text: "#{current_user.tag} loves you!", chat_id: user.chat_id } }
      subject { described_class.new(current_user, nil, payload, 'test').love_to(user) }
    end
  end

  describe '#support' do
    subject { described_class.new(current_user, nil, payload, 'test').support }

    it 'ANIKI should receive method call' do
      expect(ANIKI).to receive(:send_message)
      subject
    end
  end
end