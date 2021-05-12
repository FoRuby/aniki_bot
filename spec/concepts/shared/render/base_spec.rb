require 'rails_helper'

describe Shared::Render::Base do
  let(:user) { build :user }

  describe '#initialize' do
    subject { described_class.new(current_user: user) }

    it 'instantiates the class' do
      expect(subject).to be_an_instance_of(Shared::Render::Base)
    end

    it 'should assign current_user' do
      expect(subject.current_user).to eq user
    end
  end

  describe '.call' do
    subject { described_class.call(current_user: user) }

    it 'should call new' do
      allow(described_class).to receive(:new).with(current_user: user).and_call_original
      expect(described_class).to receive(:new).with(current_user: user)
      subject
    end
  end
end