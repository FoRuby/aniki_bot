require 'rails_helper'

describe User::Response::RefillSelect::Success, response: true do
  let(:current_user) { build_stubbed :user }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe 'render User::Render::RefillSelect' do
    include_examples '#render' do
      let(:params) { { current_user: current_user } }
      let(:render) { User::Render::RefillSelect }
      subject { described_class.new(current_user, nil, payload).render }
    end
  end

  describe '#success_respond' do
    describe 'nil render' do
      include_examples '#success_respond', :answer_callback_query do
        let(:params) { { text: 'You have not Borrowers', callback_query_id: 'id', show_alert: true } }
        subject { described_class.call(current_user, nil, payload) }
        before { allow(User::Render::RefillSelect).to receive(:call).and_return(nil) }
      end
    end

    describe 'not nil render' do
      include_examples '#success_respond', :send_message do
        let(:params) { { text: 'text', chat_id: 'chat_id', parse_mode: 'html', reply_markup: 'reply_markup' } }
        subject { described_class.call(current_user, nil, payload) }
        before { allow(User::Render::RefillSelect).to receive(:call).and_return(params.except(:chat_id)) }
      end
    end
  end
end