require 'rails_helper'

RSpec.describe Event::Parser::Description do
  let(:parser) { described_class.new(params) }

  describe 'params' do
    let(:params) { { 'text' => 'New Description' } }

    it { expect(parser.parse).to include(description: 'New Description') }
  end
end