require 'rails_helper'

describe Event::Response::Info::Success, response: true do
  include_examples 'response fixture event user'

  describe 'render Event::Render::Info' do
    include_examples '#render' do
      let(:params) { { event: event, current_user: current_user } }
      let(:render) { Event::Render::Info }
      subject { described_class.new(current_user, operation, payload).render }
    end
  end

  describe '#success_respond' do
    include_examples '#success_respond', :send_message do
      let(:params) { { text: 'text', chat_id: 'chat_id', parse_mode: 'html', reply_markup: 'reply_markup' } }
      before { allow(Event::Render::Info).to receive(:call).and_return(params) }
      subject { described_class.call(current_user, operation, payload) }
    end
  end
end