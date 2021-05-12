shared_examples_for 'render' do
  describe '#render' do
    it { expect(subject.render).to eq render }
  end
end