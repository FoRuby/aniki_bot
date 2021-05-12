require 'rails_helper'

describe Event::Response::Close::Success, response: true do
  include_examples 'response fixture event admin'

  describe '#message_text' do
    subject { described_class.new(current_user, operation, payload) }
    it 'should assign message' do
      expect(subject.message_text).to eq 'Event Name has been closed. See your finance statistic on /me => Finance'
    end
  end

  describe '#delete_edit_form' do
    include_examples '#success_respond', :delete_message do
      let(:params) { { chat_id: 'chat_id', message_id: 'message_id' } }
      subject { described_class.new(current_user, operation, payload).delete_edit_form }
    end
  end

  describe '#unpin_message' do
    include_examples '#success_respond', :unpin_chat_message do
      let(:params) { { chat_id: 'chat_id', message_id: 'message_id' } }
      subject { described_class.new(current_user, operation, payload, session_payload: payload).unpin_message }
    end
  end

  describe '#send_private_message' do
    include_examples '#success_respond', :send_message do
      let(:params) { { chat_id: 'chat_id', text: 'Event Name has been closed. See your finance statistic on /me => Finance' } }
      subject { described_class.new(current_user, operation, payload).send_private_message }
    end
  end

  describe '#send_group_message' do
    include_examples '#success_respond', :send_message do
      let(:params) { { chat_id: 'chat_id', text: 'Event Name has been closed. See your finance statistic on /me => Finance' } }
      subject { described_class.new(current_user, operation, payload, session_payload: payload).send_group_message }
    end
  end
end