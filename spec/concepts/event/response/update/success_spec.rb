require 'rails_helper'

describe Event::Response::Update::Success, response: true do
  include_examples 'response fixture event user'

  describe 'render Event::Render::Edit' do
    include_examples '#render' do
      let(:params) { { event: event, current_user: current_user } }
      let(:render) { Event::Render::Edit }
      subject { described_class.new(current_user, operation, payload).render_edit }
    end
  end

  describe 'render Event::Render::Show' do
    include_examples '#render' do
      let(:params) { { event: event, current_user: current_user } }
      let(:render) { Event::Render::Show }
      subject { described_class.new(current_user, operation, payload).render_show }
    end
  end

  describe '#success_respond' do
    let(:response_params) { { text: 'text', chat_id: 'chat_id', parse_mode: 'html', reply_markup: 'reply_markup' } }
    before do
      allow(Event::Render::Edit).to receive(:call).and_return(response_params)
      allow(Event::Render::Show).to receive(:call).and_return(response_params)
      allow(ANIKI).to receive(:edit_message_text)
    end

    subject do
      described_class.call(
        current_user, operation, payload,
        session_payload: {
          edit_event: { message: { chat: { id: 'edit_event_chat_id' }, message_id: 'edit_event_message_id' } },
          show_event: { message: { chat: { id: 'show_event_chat_id' }, message_id: 'show_event_message_id' } }
        }
      )
    end

    describe 'send_message' do
      it_behaves_like '#success_respond', :send_message do
        let(:params) { { chat_id: 'chat_id', text: 'Event successfully updated' } }
      end
    end


    describe 'edit_message_text' do
      it_behaves_like '#success_respond', :edit_message_text do
        let(:params) { response_params.merge({ chat_id: 'show_event_chat_id', message_id: 'show_event_message_id' }) }
      end
    end

    describe 'edit_message_text' do
      it_behaves_like '#success_respond', :edit_message_text do
        let(:params) { response_params.merge({ chat_id: 'edit_event_chat_id', message_id: 'edit_event_message_id' }) }
      end
    end
  end
end