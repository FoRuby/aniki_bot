shared_examples_for 'text' do
  describe '#text' do
    it { expect(subject.text).to eq text }
  end
end