shared_examples_for 'invalid create feedback operation' do
  it { should be_failure }
  it { expect { subject }.to_not change(Feedback, :count) }
end