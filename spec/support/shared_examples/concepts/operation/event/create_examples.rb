shared_examples_for 'invalid create event operation' do
  it { should be_failure }
  it { expect { subject }.to_not change(Event, :count) }
  it { expect { subject }.to_not change(UserEvent, :count) }
end