require 'rails_helper'

describe Event::Response::AddAdminSelect::Success, response: true do
  include_examples 'response fixture event admin'

  subject { described_class.call(current_user, operation, payload) }

  describe 'render Event::Render::AddAdminSelect' do
    include_examples '#render' do
      let(:params) { { event: event, current_user: current_user } }
      let(:render) { Event::Render::AddAdminSelect }
      subject { described_class.new(current_user, operation, payload).render }
    end
  end

  describe '#success_respond' do
    let(:response_params) { { text: 'text', chat_id: 'chat_id', parse_mode: 'html', reply_markup: 'reply_markup' } }
    before do
      allow(Event::Render::AddAdminSelect)
        .to receive(:call).and_return(response_params.slice(:text, :parse_mode, :reply_markup))
    end
    subject { described_class.call(current_user, operation, payload) }

    describe 'users: 1, admins: 1' do
      include_examples '#success_respond', :answer_callback_query do
        let(:params) { { callback_query_id: 'id', text: 'No users to promote', show_alert: true } }
      end
    end

    describe 'users: 2, admins: 1' do
      include_examples '#success_respond', :send_message do
        let(:params) { response_params }
        before { create :user_event, event: event }
      end
    end
  end
end