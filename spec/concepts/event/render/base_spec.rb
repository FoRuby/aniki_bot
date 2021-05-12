require 'rails_helper'

describe Event::Render::Base do
  subject { described_class.new(event: event, current_user: user) }

  describe '#initialize' do
    let(:event) { build :event }
    let(:user) { build :user }

    it 'instantiates the class' do
      expect(subject).to be_an_instance_of(Event::Render::Base)
    end

    it 'should assign event' do
      expect(subject.event).to eq event
    end

    it 'should assign current_user' do
      expect(subject.current_user).to eq user
    end
  end
end