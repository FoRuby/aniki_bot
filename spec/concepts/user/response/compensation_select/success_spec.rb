require 'rails_helper'

describe User::Response::CompensationSelect::Success, response: true do
  let(:current_user) { build_stubbed :user }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe 'render User::Render::CompensationSelect' do
    include_examples '#render' do
      let(:params) { { current_user: current_user } }
      let(:render) { User::Render::CompensationSelect }
      subject { described_class.new(current_user, nil, payload).render }
    end
  end

  describe '#success_respond' do
    describe 'nil render' do
      include_examples '#success_respond', :answer_callback_query do
        let(:params) { { text: 'You have not users to compensate', callback_query_id: 'id', show_alert: true } }
        subject { described_class.call(current_user, nil, payload) }
        before { allow(User::Render::CompensationSelect).to receive(:call).and_return(nil) }
      end
    end

    describe 'not nil render' do
      include_examples '#success_respond', :send_message do
        let(:params) { { text: 'text', chat_id: 'chat_id', parse_mode: 'html', reply_markup: 'reply_markup' } }
        subject { described_class.call(current_user, nil, payload) }
        before { allow(User::Render::CompensationSelect).to receive(:call).and_return(params.except(:chat_id)) }
      end
    end
  end
end