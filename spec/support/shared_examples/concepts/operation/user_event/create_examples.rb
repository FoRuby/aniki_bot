shared_examples_for 'invalid create user_event operation' do
  it { should be_failure }
  it { expect { subject }.to_not change(UserEvent, :count) }
end