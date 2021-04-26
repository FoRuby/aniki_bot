require 'rails_helper'

RSpec.describe UserEventPolicy do
  let!(:event_admin) { create :user }
  let!(:event_member) { create :user }
  let!(:event) do
    Event::Operation::Create.call(
      current_user: event_admin,
      params: attributes_for(:event).merge(date: (Time.now + 1.day).strftime('%F %H:%M'))
    )[:model]
  end
  let!(:model) do
    UserEvent::Operation::Create.call(current_user: event_member,
                                      params: { event_id: event.id, user_id: event_member.id })[:model]
  end
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