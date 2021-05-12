shared_examples_for '#render' do
  it do
    expect(render).to receive(:call).with(params)
    subject
  end
end

shared_examples_for '#success_respond' do |method|
  it 'ANIKI should receive method call' do
    expect(ANIKI).to receive(method).with(params)
    subject
  end
end