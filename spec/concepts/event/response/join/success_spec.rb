require 'rails_helper'

describe Event::Response::Join::Success, response: true do
  include_examples 'response fixture user_event user'

  describe 'render Event::Render::Show' do
    include_examples '#render' do
      let(:params) { { event: event, current_user: current_user } }
      let(:render) { Event::Render::Show }
      subject { described_class.new(current_user, operation, payload).render }
    end
  end

  describe '#success_respond' do
    subject { described_class.call(current_user, operation, payload) }
    before { allow(Event::Render::Show).to receive(:call).and_return(params.except(:chat_id, :message_id)) }

    describe 'answer_callback_query' do
      include_examples '#success_respond', :answer_callback_query do
        let(:params) { { callback_query_id: 'id', text: 'You have joined the event', show_alert: true } }
      end
    end

    describe 'edit_message_text' do
      include_examples '#success_respond', :edit_message_text do
        let(:params) { { text: 'text', chat_id: 'chat_id', message_id: 'message_id', parse_mode: 'html', reply_markup: 'reply_markup' } }
      end
    end
  end
end