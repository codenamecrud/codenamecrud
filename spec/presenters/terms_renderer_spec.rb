require 'rails_helper'

RSpec.describe TermsRenderer do

  describe '#render' do
    subject { TermsRenderer.new(text).render }
    let!(:term_controller) { create :terms }

    context 'when terms exists in the text' do
      let(:text) do
        %{
          <p>
            <h1>Контроллеры</h1>
            Контроллер (Controller) - посредник между моделью и представлением. Основная же его работа заключается в том, чтобы собрать необходимый набор переменных экземпляра и отправить его представлению.
          </p>
         }
      end
      let(:text_result) do
        %{
          <p>
            <h1>Контроллеры</h1>
            <span class='vocabulary-highlight' data-toggle='tooltip' data-placement='top' title="Контроллер (Controller) - посредник между моделью и представлением <a href='/path/to_terms/controller'>Подробно</a>">Контроллер (Controller)</span> - посредник между моделью и представлением. Основная же его работа заключается в том, чтобы собрать необходимый набор переменных экземпляра и отправить его представлению.
          </p>
         }
      end

      it 'return html string with highlight term' do
        is_expected.to eq text_result
      end
    end

    context 'when terms not exists or exists inside tags <code>, <a>  in the text' do
      let(:text) do
        %{
          <div>
            <p>
              <h1>Система контроля версии</h1>
              Система контроля версии (Version control system) - это программа позволяет хранить несколько версий одного и того же файла.
            </p>
            <code> myterm = 'Контроллер (Controller)' </code>
          </div>
         }
      end

      it 'returns html string without highlight term' do
        is_expected.to eq text
      end
    end
  end
end
