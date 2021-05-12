require 'rails_helper'

describe Event::Response::Pay::Success, response: true do
  include_examples 'response fixture user_event user'

  describe 'render Event::Render::Show' do
    include_examples '#render' do
      let(:params) { { event: event, current_user: current_user } }
      let(:render) { Event::Render::Show }
      subject { described_class.new(current_user, operation, payload).render }
    end
  end

  describe '#success_respond' do
    let(:params) { { text: 'text', chat_id: 'chat_id', parse_mode: 'html', reply_markup: 'reply_markup' } }
    before { allow(Event::Render::Show).to receive(:call).and_return(params.except(:chat_id)) }
    subject do
      described_class.call(
        current_user, operation, payload,
        session_payload: { message: { chat: { id: 'show_event_chat_id' }, message_id: 'show_event_message_id'} }
      )
    end

    it_behaves_like '#success_respond', :send_message do
      let(:params) { { chat_id: current_user.chat_id, text: 'Payment accepted' } }
    end
    it_behaves_like '#success_respond', :edit_message_text do
      let(:params) { { chat_id: 'show_event_chat_id', message_id: 'show_event_message_id' } }
    end
  end
end