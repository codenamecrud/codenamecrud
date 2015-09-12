require 'rails_helper'

describe ApplicationHelper do
  describe '#breadcrumbs' do
    it 'returns proper breadcrumbs' do
      @course = create(:course)
      @section = create(:section, course: @course)
      @lesson = create(:lesson, section: @section, course: @course)

      expect(helper.breadcrumbs).to eq([link_to('Список курсов', pages_curriculum_path), link_to(@lesson.course.title, course_path(@lesson.course)), link_to(@lesson.section.title, course_path(@lesson.course, anchor: "section-#{@lesson.section.slug}")), @lesson.title])
    end
  end

  describe '#next_lesson_path' do
    it 'returns blank' do
      expect(helper.next_lesson_path).to be_blank
    end
  end

  describe '#consistency_data' do
    before do
      require 'rake'
      load File.join(Rails.root, 'Rakefile')
      Rake::Task['curriculum:db_populate'].invoke
      Rake::Task['curriculum:update_content'].invoke
    end

    let(:links_course) do
      [
        '/introduction_to_web_development/01_what_does_a_web_dev_do.md',
        '/introduction_to_web_development/02_web_dev_jobs.md',
        '/introduction_to_web_development/03_tools_of_trade.md',
        '/introduction_to_web_development/04_web_dev_communities.md',
        '/introduction_to_web_development/05_the_best_web_devs.md',
        '/introduction_to_web_development/06_getting_hired_as_a_web_dev.md',
        '/introduction_to_web_development/07_conclusion.md',
        #7
        '/web_development_101/01_how_this_course_will_work.md',
        '/web_development_101/02_how_does_the_web_work.md',
        '/web_development_101/03_how_does_your_computer_work.md',
        '/web_development_101/04_terms_to_know.md',
        '/web_development_101/05_project_installations.md',
        '/web_development_101/06_introduction_to_the_front_end.md',
        '/web_development_101/07_html_css_basics.md',
        '/web_development_101/08_project_html_css.md',
        '/web_development_101/09_javascript_basics.md',
        '/web_development_101/10_jquery_basics.md',
        '/web_development_101/11_project_js_jquery.md',
        '/web_development_101/12_introduction_to_the_back_end.md',
        '/web_development_101/13_ruby_basics.md',
        '/web_development_101/14_testing_basics.md',
        '/web_development_101/15_project_ruby.md',
        '/web_development_101/16_database_basics.md',
        '/web_development_101/17_introduction_to_frameworks.md',
        '/web_development_101/18_rails_basics.md',
        '/web_development_101/19_project_rails.md',
        '/web_development_101/20_backbone_basics.md',
        '/web_development_101/21_git_basics.md',
        '/web_development_101/22_the_cloud_hosting_and_saas.md',
        '/web_development_101/23_security_ssl_and_best_practices.md',
        '/web_development_101/24_ftp_basics.md',
        '/web_development_101/25_how_are_websites_built.md',
        '/web_development_101/26_principles_of_good_programming.md',
        '/web_development_101/27_conclusion.md',
        #34
        '/ruby/01_how_this_course_will_work.md',
        '/ruby/01_how_this_course_will_work.md',
        '/ruby/02_building_blocks.md',
        '/ruby/03_project_building_blocks.md',
        '/ruby/04_advanced_building_blocks.md',
        '/ruby/05_project_advanced_building_blocks.md',
        '/ruby/06_oop.md',
        '/ruby/07_project_oop.md',
        '/ruby/08_serialization.md',
        '/ruby/09_project_file_io.md',
        '/ruby/10_bringing_ruby_online.md',
        '/ruby/11_project_web.md',
        '/ruby/12_a_very_brief_intro_to_cs.md',
        '/ruby/13_recursion.md',
        '/ruby/14_project_recursion.md',
        '/ruby/15_data_structures_algorithms.md',
        '/ruby/16_project_data_structures_algorithms.md',
        '/ruby/17_introduction_to_rspec.md',
        '/ruby/18_project_testing.md',
        '/ruby/19_a_deeper_look_at_git.md',
        '/ruby/20_using_git_in_the_real_world.md',
        '/ruby/21_project_final.md',
        '/ruby/22_conclusion.md'
        #56
      ]
    end
    let(:git) { Github::Client::Repos.new user: 'codenamecrud', repo: 'curriculum', oauth_token: "#{ENV['GITHUB_API_TOKEN']}" }

    skip 'all lessons should be valid' do
      links_course.each.with_index(1) do |item, index|
        res = git.contents.get path: item
        article = Base64.decode64(res['content']).force_encoding('UTF-8')
        article_in_db = Lesson.find_by_sql(["SELECT content FROM lessons WHERE id = ?", index])

        expect(article).to eq(article_in_db[0][:content])
      end
    end
  end
end
