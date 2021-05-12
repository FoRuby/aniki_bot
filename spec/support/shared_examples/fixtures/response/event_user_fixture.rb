RSpec.shared_context 'response fixture event user' do
  let(:event) { build_stubbed :event }
  let(:current_user) { build_stubbed :user }
  let(:operation) { Struct.new(:model).new(event) }
  let(:payload) { create_payload(type: 'supergroup', callback: true) }
end