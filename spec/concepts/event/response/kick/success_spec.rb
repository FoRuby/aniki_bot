require 'rails_helper'

describe Event::Response::Kick::Success, response: true do
  include_examples 'response fixture user_event admin'

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

    describe 'answer_callback_query' do
      it_behaves_like '#success_respond', :answer_callback_query do
        let(:params) { { callback_query_id: 'id', text: 'You kicked out @bar', show_alert: true } }
      end
    end

    describe 'delete_message' do
      it_behaves_like '#success_respond', :delete_message do
        let(:params) { { chat_id: 'chat_id', message_id: 'message_id' } }
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