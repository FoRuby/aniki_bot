shared_examples_for 'reply_markup' do
  describe '#reply_markup' do
    it { expect(subject.reply_markup).to eq({ inline_keyboard: inline_keyboard }) }
  end
end