require 'rails_helper'

RSpec.describe User::Parser::Base do
  let(:parser) { described_class.new(params) }

  describe 'params' do
    let(:chat_id) { Faker::Number.number(digits: 10) }
    let(:first_name) { Faker::Name.first_name }
    let(:last_name) { Faker::Name.last_name }
    let(:username) { Faker::Internet.username }

    let(:params) { { id: chat_id, first_name: first_name, last_name: last_name, username: username } }

    it 'should assign attributes' do
      expect(parser.parse[:chat_id]).to eq chat_id
      expect(parser.parse[:first_name]).to eq first_name
      expect(parser.parse[:last_name]).to eq last_name
      expect(parser.parse[:username]).to eq username
    end
  end
end