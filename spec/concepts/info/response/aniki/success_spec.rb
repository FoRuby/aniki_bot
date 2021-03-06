require 'rails_helper'

describe Info::Response::Aniki::Success, response: true do
  let(:current_user) { build_stubbed :user }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe '#success_respond' do
    include_examples '#success_respond', :send_photo do
      let(:params) { { photo: nil, chat_id: 'chat_id', caption: "Hello! It's me, ANIKI!" } }
      before { allow(File).to receive(:open).and_return(nil) }
      subject { described_class.call(current_user, nil, payload) }
    end
  end
end