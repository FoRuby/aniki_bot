require 'rails_helper'

RSpec.describe UserEventPolicy do
  before_all do
    @admin = create :user
    @event = create :event, :with_admin, user: @admin
    @event_member = create :user
    @user_event = create :user_event, event: @event, user: @event_member
  end
  let(:event_admin) { @admin }
  let(:event) { @event }
  let(:event_member) { @event_member }
  let(:model) { @user_event }
  let(:policy) { described_class.new(user, model) }

  describe '#create?' do
    subject { policy.apply(:create?) }

    describe 'event_member' do
      let(:user) { event_member }
      it { should be_truthy }
    end

    describe 'event_admin' do
      let(:user) { event_admin }
      it { should be_truthy }
    end

    describe 'user' do
      let(:user) { create :user }
      it { should be_truthy }
    end

    describe 'nil' do
      let(:user) { nil }
      it { should be_falsey }
    end
  end

  describe '#update?' do
    subject { policy.apply(:update?) }

    describe 'event_member' do
      let(:user) { event_member }
      it { should be_truthy }
    end

    describe 'event_admin' do
      let(:user) { event_admin }
      it { should be_falsey }
    end

    describe 'user' do
      let(:user) { create :user }
      it { should be_falsey }
    end

    describe 'nil' do
      let(:user) { nil }
      it { should be_falsey }
    end
  end

  describe '#edit?' do
    subject { policy.apply(:edit?) }

    describe 'event_member' do
      let(:user) { event_member }
      it { should be_truthy }
    end

    describe 'event_admin' do
      let(:user) { event_admin }
      it { should be_falsey }
    end

    describe 'user' do
      let(:user) { create :user }
      it { should be_falsey }
    end

    describe 'nil' do
      let(:user) { nil }
      it { should be_falsey }
    end
  end

  describe '#delete?' do
    subject { policy.apply(:delete?) }

    describe 'event_member' do
      let(:user) { event_member }
      it { should be_truthy }
    end

    describe 'event_admin' do
      let(:user) { event_admin }
      it { should be_truthy }
    end

    describe 'user' do
      let(:user) { create :user }
      it { should be_falsey }
    end

    describe 'nil' do
      let(:user) { nil }
      it { should be_falsey }
    end
  end

  describe '#add_admin?' do
    subject { policy.apply(:delete?) }

    describe 'event_member' do
      let(:user) { event_member }
      it { should be_truthy }
    end

    describe 'event_admin' do
      let(:user) { event_admin }
      it { should be_truthy }
    end

    describe 'user' do
      let(:user) { create :user }
      it { should be_falsey }
    end

    describe 'nil' do
      let(:user) { nil }
      it { should be_falsey }
    end
  end
end