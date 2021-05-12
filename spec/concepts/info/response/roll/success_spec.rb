require 'rails_helper'

describe Info::Response::Roll::Success, response: true do
  let(:current_user) { build_stubbed :user }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe '#success_respond' do
    include_examples '#success_respond', :send_animation do
      let(:params) { { animation: nil, chat_id: 'chat_id', reply_to_message_id: 'message_id', caption: '33' } }
      before do
        allow_any_instance_of(Object).to receive(:rand).and_return(33)
        allow(File).to receive(:open).and_return(nil)
      end
      subject { described_class.call(current_user, nil, payload) }
    end
  end
end