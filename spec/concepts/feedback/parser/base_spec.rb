require 'rails_helper'

RSpec.describe Feedback::Parser::Base do
  let(:parser) { described_class.new(params) }

  describe 'params' do
    let(:params) { %w[New Feedback] }

    it { expect(parser.parse).to include(message: 'New Feedback') }
  end
end