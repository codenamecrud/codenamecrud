module PagesHelper
  def show_contributor(contributor)
    content_tag(:div, class: 'contributor') do
      link_to contributor['html_url'], target: '_blank' do
        image_tag(contributor['avatar_url'], size: '48x48', data: { toggle: 'tooltip', placement: 'top' }, title: contributor['login'])
      end
    end
  end
end
