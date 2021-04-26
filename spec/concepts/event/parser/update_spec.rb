require 'rails_helper'

RSpec.describe Event::Parser::Update do
  subject(:parser) { described_class.call(params) }

  describe '.call' do
    describe 'valid' do
      let(:params) { %w[EventName 2021-11-11 19:00] }

      it { expect(parser[:name]).to eq 'EventName' }
      it { expect(parser[:date]).to eq '2021-11-11 19:00' }
    end

    describe 'valid without date' do
      let(:params) { %w[New event name] }

      it { expect(parser[:name]).to eq 'New event name' }
      it { expect(parser[:date]).to be_nil }
    end

    describe 'valid without date' do
      let(:params) { %w[New event name 19:00] }

      it { expect(parser[:name]).to eq 'New event name' }
      it { expect(parser[:date]).to eq '19:00' }
    end

    describe 'valid without name' do
      let(:params) { %w[2021-11-11 19:00] }

      it { expect(parser[:name]).to be_nil }
      it { expect(parser[:date]).to eq '2021-11-11 19:00' }
    end

    describe 'valid without params' do
      let(:params) { [] }

      it { expect(parser[:name]).to be_nil }
      it { expect(parser[:date]).to be_nil }
    end
  end
end