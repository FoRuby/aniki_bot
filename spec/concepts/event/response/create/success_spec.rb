require 'rails_helper'

describe Event::Response::Create::Success, response: true do
  include_examples 'response fixture event user'

  describe 'render Event::Render::Show' do
    include_examples '#render' do
      let(:params) { { event: event, current_user: current_user } }
      let(:render) { Event::Render::Show }
      subject { described_class.new(current_user, operation, payload).render }
    end
  end

  describe '#success_respond' do
    let(:params) { { text: 'text', chat_id: 'chat_id', parse_mode: 'html', reply_markup: 'reply_markup' } }
    let(:result) { { result: { chat: { id: 'result_chat_id' }, message_id: 'result_message_id' } } }
    before do
      allow(Event::Render::Show).to receive(:call).and_return(params.except(:chat_id))
      allow(ANIKI).to receive(:send_message).and_return(result)
    end

    subject { described_class.call(current_user, operation, payload) }

    describe 'send_message' do
      include_examples '#success_respond', :send_message
    end

    describe 'pin_chat_message' do
      include_examples '#success_respond', :pin_chat_message do
        let(:params) { { chat_id: 'result_chat_id', message_id: 'result_message_id' } }
      end
    end
  end
end