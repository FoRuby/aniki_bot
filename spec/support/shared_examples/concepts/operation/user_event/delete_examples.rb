shared_examples_for 'invalid delete user_event operation' do
  it { should be_failure }
  it { expect { subject }.to_not change(UserEvent, :count) }
end

shared_examples_for 'valid delete user_event operation' do
  it { should be_success }
  it { expect { subject }.to change(UserEvent, :count).by(-1) }
end