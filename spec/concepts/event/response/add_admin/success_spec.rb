require 'rails_helper'

describe Event::Response::AddAdmin::Success, response: true do
  include_examples 'response fixture user_event user'

  subject { described_class.call(current_user, operation, payload) }

  describe 'answer_callback_query' do
    include_examples '#success_respond', :answer_callback_query do
      let(:params) { { callback_query_id: 'id', text: 'You promote @foo', show_alert: true } }
    end
  end

  describe 'delete_message' do
    include_examples '#success_respond', :delete_message do
      let(:params) { { chat_id: 'chat_id', message_id: 'message_id' } }
    end
  end
end