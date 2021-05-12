shared_examples_for 'success create debt operation' do |h|
  it { should be_success }
  it 'should creates new records' do
    expect { subject }
      .to change(Debt, :count).by(h[:debt_count])
      .and change(Refill, :count).by(h[:refill_count])
  end
end