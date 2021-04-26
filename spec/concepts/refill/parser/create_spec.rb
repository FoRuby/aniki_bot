require 'rails_helper'

RSpec.describe Refill::Parser::Create do
  subject(:parser) { described_class.call(params) }

  describe '.call' do
    describe 'valid' do
      let(:params) { %w[100] }

      it { expect(parser[:value]).to eq -100.00 }
    end

    describe 'invalid' do
      let(:params) { %w[fffffff] }

      it { expect(parser[:value]).to eq 0 }
    end
  end
end