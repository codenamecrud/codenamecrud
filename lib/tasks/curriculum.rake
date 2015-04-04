namespace :curriculum do
  desc "Get lessons from Github"
  task update_content: :environment do
    puts 'Getting content...'

    puts 'Authorizing on Github'
    github = Github::Repos.new user: 'enfield-rookies', repo: 'curriculum', oauth_token: "#{ENV['GITHUB_API_TOKEN']}"

    lessons = Lesson.all
    count = lessons.count

    puts "Cycling through #{count} lessons... \n\n\n"
    lessons.each_with_index do |lesson, index|
      puts "Retrieving Lesson #{index}/#{count}: #{lesson.title}"
      response = github.contents.get path: lesson.url

      decoded_file = Base64.decode64(response['content'])

      if decoded_file
        snippet_end = decoded_file.index('\n')-1 || 03
        if lesson.content == decoded_file
          puts '    ...No new content.'
        else
          puts "    Adding content: \"#{decoded_file[0..snippet_end]}\""
          lesson.content = decoded_file
          lesson.save!
        end
        puts
      else
        puts "\n\n\n\n\n\n FAILED TO ADD CONTENT TO THE LESSON!!!\n\n\n\n\n\n"
        raise "Failed to add content to the lesson (tried to add `nil`)!"
      end
    end

    puts '\nChecking for any nils or blanks in the database'
    Lesson.all.each do |l|
      print '.'
      raise "Nil lesson content error! Lesson was #{l.title}." if l.content.nil?
      raise "Blank lesson content error! Lesson was #{l.title}." if l.content.blank?
    end
    puts '\n...All lessons appear to have content.'
    puts '...so we\'re ALL DONE! Updated the curriculum.'
  end

end
