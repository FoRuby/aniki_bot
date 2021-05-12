require 'rails_helper'

describe Changelog::Response::Show::Success, response: true do
  let(:current_user) { build_stubbed :user }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }

  describe '#data' do
    before { allow(File).to receive(:read).and_return('test') }
    subject { described_class.new(current_user, nil, payload, 'RU').data }

    describe 'file exist' do
      before { allow(File).to receive(:exist?).and_return(true) }
      it { is_expected.to eq 'test' }
    end

    describe 'file does not exist' do
      before { allow(File).to receive(:exist?).and_return(false) }
      it { is_expected.to eq 'test' }
    end
  end

  describe '#success_respond' do
    before do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return('test')
    end
    subject { described_class.call(current_user, nil, payload, 'EN') }

    describe '#send_message' do
      include_examples '#success_respond', :send_message do
        let(:params) { { chat_id: current_user.chat_id, text: 'test' } }
      end
    end
  end
end