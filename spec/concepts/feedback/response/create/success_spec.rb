require 'rails_helper'

describe Feedback::Response::Create::Success, response: true do
  let(:payload) { create_payload(type: 'supergroup', callback: true) }
  let(:current_user) { build_stubbed :user }

  describe '#success_respond' do
    include_examples '#success_respond', :send_message do
      let(:params) { { text: '♂Aniki♂ will read your complaint and write back to you', chat_id: 'chat_id' } }
      subject { described_class.call(current_user, nil, payload) }
    end
  end
end