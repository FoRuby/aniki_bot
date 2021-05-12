require 'rails_helper'

describe Info::Response::Start::Success, response: true do
  let(:current_user) { build_stubbed :user }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe '#success_respond' do
    include_examples '#success_respond', :send_message do
      let(:params) { { text: text, chat_id: 'chat_id' } }
      let(:text) { I18n.t('telegram_webhooks.start.content') }
      before { allow(File).to receive(:open).and_return(nil) }
      subject { described_class.call(current_user, nil, payload) }
    end
  end
end