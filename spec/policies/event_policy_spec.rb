require 'rails_helper'

RSpec.describe EventPolicy do
  let(:policy) { described_class.new(user, model) }
  let!(:event_admin) { create :user }
  let!(:event_member) { create :user }
  let(:model) do
    Event::Operation::Create.call(
      current_user: event_admin,
      params: attributes_for(:event).merge(date: (Time.now + 1.day).strftime('%F %H:%M'))
    )[:model]
  end

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

  describe '#update?' do
    subject { policy.apply(:update?) }

    describe 'event_member' do
      before do
        UserEvent::Operation::Create.call(current_user: event_member,
                                          params: { event_id: model.id, user_id: event_member.id })[:model]

      end

      let(:user) { event_member }
      it { should be_falsey }
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

  describe '#edit?' do
    subject { policy.apply(:edit?) }

    describe 'event_member' do
      before do
        UserEvent::Operation::Create.call(current_user: event_member,
                                          params: { event_id: model.id, user_id: event_member.id })[:model]

      end

      let(:user) { event_member }
      it { should be_falsey }
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

  describe '#close?' do
    subject { policy.apply(:close?) }

    describe 'event_member' do
      before do
        UserEvent::Operation::Create.call(current_user: event_member,
                                          params: { event_id: model.id, user_id: event_member.id })[:model]

      end

      let(:user) { event_member }
      it { should be_falsey }
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