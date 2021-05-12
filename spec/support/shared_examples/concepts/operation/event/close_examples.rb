shared_examples_for 'invalid close event operation' do
  it { should be_failure }
  it 'should not creates new records' do
    expect { subject }
      .to change(Debt, :count).by(0)
      .and change(Refill, :count).by(0)
  end
end

shared_examples_for 'success close event operation' do |h|
  it { should be_success }
  it 'should creates new records' do
    expect { subject }
      .to change(Debt, :count).by(h[:debt_count])
      .and change(Refill, :count).by(h[:refill_count])
  end
end