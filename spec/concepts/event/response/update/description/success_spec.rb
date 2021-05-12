require 'rails_helper'

describe Event::Response::Update::Description::Success, response: true do
  include_examples 'response fixture event user'

  describe '#success_respond' do
    include_examples '#success_respond', :send_message do
      let(:params) { { chat_id: 'chat_id', text: 'Event description successfully updated' } }
      subject { described_class.call(current_user, operation, payload) }
    end
  end
end