require 'rails_helper'

describe PagesHelper do
  describe '#show_contributor' do
    it 'page should have div contributor' do
      visit pages_contribute_path
      expect(page).to have_css('div.contributor')
      expect(page).to have_css('div.contributor > a')
      expect(page).to have_css('div.contributor > a > img')
    end

    it 'tested all item for curriculum' do
      contribute

      @curriculum.each do |contributor|
        item = show_contributor(contributor)

        expect(item).to have_css('div.contributor')
        expect(item).to have_css('div.contributor > a')
        expect(item).to have_css('div.contributor > a > img')

        expect(item).to eq(
          content_tag(:div, class: 'contributor') do
            link_to contributor['html_url'], target: '_blank' do
              image_tag(contributor['avatar_url'], size: '48x48', data: { toggle: 'tooltip', placement: 'top' }, title: contributor['login'])
            end
          end)
      end
    end
  end
end
