require 'rails_helper'

RSpec.describe Event::Parser::Create do
  let(:parser) { described_class.new(params) }

  describe 'params' do
    let(:params) { %w[Foobar 2021-11-11 19:00] }

    it { expect(parser.name).to eq 'Foobar' }
    it { expect(parser.date).to eq '2021-11-11 19:00' }
    it { expect(parser.parse).to include(name: 'Foobar', date: '2021-11-11 19:00') }
  end

  describe 'params without name' do
    let(:params) { %w[2021-11-11 19:00] }

    it { expect(parser.name).to eq 'New Event' }
    it { expect(parser.date).to eq '2021-11-11 19:00' }
    it { expect(parser.parse).to include(name: 'New Event', date: '2021-11-11 19:00') }
  end

  describe 'params without name & date' do
    let(:params) { %w[19:00] }

    it { expect(parser.name).to eq 'New Event' }
    it { expect(parser.date).to eq "#{Time.zone.now.to_date} 19:00" }
    it { expect(parser.parse).to include(name: 'New Event', date: "#{Time.zone.now.to_date} 19:00") }
  end

  describe 'params without name & date & datetime' do
    let(:params) { %w[] }
    let(:date) { "#{Time.zone.now.to_date} #{(Time.zone.now + 1.hour).beginning_of_hour.strftime('%H:%M')}" }

    it { expect(parser.name).to eq 'New Event' }
    it { expect(parser.date).to eq date }
    it { expect(parser.parse).to include(name: 'New Event', date: date) }
  end
end