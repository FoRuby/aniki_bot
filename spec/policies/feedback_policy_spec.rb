require 'rails_helper'

RSpec.describe FeedbackPolicy do
  let(:policy) { described_class.new(user, model) }
  let(:model) { build :feedback }

  describe '#create?' do
    subject { policy.apply(:create?) }

    describe 'user' do
      let(:user) { create :user }
      it { should be_truthy }
    end

    describe 'nil' do
      let(:user) { nil }
      it { should be_falsey }
    end
  end
end