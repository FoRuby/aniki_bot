shared_examples_for 'invalid close event operation' do
  it { should be_failure }
  it { expect { operation }.not_to change(Debt, :count) }
end