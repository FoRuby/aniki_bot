require 'rails_helper'

describe User::Response::Me::Success, response: true do
  let(:current_user) { build_stubbed :user }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe 'render User::Render::Me' do
    include_examples '#render' do
      let(:params) { { current_user: current_user } }
      let(:render) { User::Render::Me }
      subject { described_class.new(current_user, nil, payload).render }
    end
  end

  include_examples '#success_respond', :send_message do
    let(:params) { { text: 'text', chat_id: 'chat_id', parse_mode: 'html', reply_markup: 'reply_markup' } }
    subject { described_class.call(current_user, nil, payload) }
    before { allow(User::Render::Me).to receive(:call).and_return(params) }
  end
end