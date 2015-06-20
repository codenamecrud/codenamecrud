require 'rails_helper'

RSpec.describe MarkdownPresenter, type: :model do
  describe '.call' do
    subject { MarkdownPresenter.call text }

    context 'when text is blank' do
      let(:text) { '' }

      it { is_expected.to eq '' }
    end

    context 'when text is present' do
      let(:text) { '# Header' }

      it 'return converted text to HTML' do
        is_expected.to eq "<h1>Header</h1>\n"
      end
    end
  end
end
