RSpec.shared_context 'response fixture event admin' do
  before_all do
    @admin = create :user, username: 'foo'
    @event = create :event, :with_admin, user: @admin, name: 'Name'
  end
  let(:admin) { @admin }
  let(:event) { @event }

  let(:current_user) { admin }
  let(:operation) { Struct.new(:model).new(event) }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }
end