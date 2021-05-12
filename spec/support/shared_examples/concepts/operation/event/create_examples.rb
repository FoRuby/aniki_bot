shared_examples_for 'invalid create event operation' do
  it { should be_failure }
  it 'should not creates new records' do
    expect { subject }
      .to change(Event, :count).by(0)
      .and change(UserEvent, :count).by(0)
  end
end