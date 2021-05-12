require 'rails_helper'

describe Event::Response::Show::Success, response: true do
  include_examples 'response fixture event user'

  describe 'render Event::Render::Show' do
    include_examples '#render' do
      let(:params) { { event: event, current_user: current_user } }
      let(:render) { Event::Render::Show }
      subject { described_class.new(current_user, operation, payload).render }
    end
  end

  include_examples '#success_respond', :send_message do
    let(:params) { { text: 'text', chat_id: 'chat_id', parse_mode: 'html', reply_markup: 'reply_markup' } }
    subject { described_class.call(current_user, operation, payload) }
    before { allow(Event::Render::Show).to receive(:call).and_return(params.except(:chat_id)) }
  end
end