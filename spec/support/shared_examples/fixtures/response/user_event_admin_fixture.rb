RSpec.shared_context 'response fixture user_event admin' do
  before_all do
    @admin = create :user, username: 'foo'
    @user = create :user, username: 'bar'
    @event = create :event
    @user_event = create :user_event, user: @user, event: @event
  end
  let(:admin) { @admin }
  let(:user) { @user }
  let(:event) { @event }
  let(:user_event) { @user_event }

  let(:current_user) { admin }
  let(:operation) { Struct.new(:model).new(user_event) }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }
end