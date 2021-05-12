shared_examples_for 'success create refill operation' do
  it { should be_success }
  it { expect { operation }.to change(Refill, :count).by(1) }
end