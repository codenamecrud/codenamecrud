interactor :simple

guard :livereload do
  watch(%r{app/views/.+.(erb|slim)$})
  watch(%r{app/helpers/.+.rb})
  watch(%r{app/assets/.+.yml})
  watch(%r{public/.+.(css|js|html)})
  watch(%r{config/locales/.+.yml})
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(sass))).*}) do |m|
    "/assets/#{m[3].sub!('.sass', '.css')}"
  end
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(scss))).*}) do |m|
    "/assets/#{m[3].sub!('.scss', '.css')}"
  end
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(coffee))).*}) do |m|
    "/assets/#{m[3].sub!('.coffee', '.js')}"
  end
end

guard :bundler do
  watch('Gemfile')
end

guard :rails do
  watch('Gemfile.lock')
  watch(%r{^(config|lib|api)/.*})
end

guard :rspec, cmd: 'CODECLIMATE_REPO_TOKEN=922a1d5f9bd1031196c6f7aef399a7d015f407d681231bcb0961a37562840980 bundle exec rspec' do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w(erb haml slim))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [
      rspec.spec.call("routing/#{m[1]}_routing"),
      rspec.spec.call("controllers/#{m[1]}_controller"),
      rspec.spec.call("acceptance/#{m[1]}")
    ]
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs) { |m| rspec.spec.call("features/#{m[1]}") }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance'
  end
end
