RSpec.shared_context 'response fixture user_event user' do
  before_all do
    @user = create :user, username: 'foo'
    @event = create :event, name: 'Name'
    @user_event = create :user_event, user: @user, event: @event
  end
  let(:user) { @user }
  let(:event) { @event }
  let(:user_event) { @user_event }

  let(:current_user) { user }
  let(:operation) { Struct.new(:model).new(user_event) }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }
end