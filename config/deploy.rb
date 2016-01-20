require 'bundler/capistrano'
require 'whenever/capistrano'
load 'deploy/assets'

after 'deploy', 'refresh_sitemaps'

## Чтобы не хранить database.yml в системе контроля версий, поместите
## dayabase.yml в shared-каталог проекта на сервере и раскомментируйте
## следующие строки.

after 'deploy:update_code', :copy_database_config
task :copy_database_config, roles: :app do
  db_config = "#{shared_path}/database.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
end

after 'deploy:update_code', :copy_secrets_config
task :copy_secrets_config, roles: :app do
  db_config = "#{shared_path}/secrets.yml"
  run "cp #{db_config} #{release_path}/config/secrets.yml"
end

after 'deploy:update_code', :copy_application_config
task :copy_application_config, roles: :app do
  db_config = "#{shared_path}/application.yml"
  run "cp #{db_config} #{release_path}/config/application.yml"
end

# Для удобства работы мы рекомендуем вам настроить авторизацию
# SSH по ключу. При работе capistrano будет использоваться
# ssh-agent, который предоставляет возможность пробрасывать
# авторизацию на другие хосты.
# Если вы не используете авторизацию SSH по ключам И ssh-agent,
# закомментируйте эту опцию.
ssh_options[:forward_agent] = true

# Имя вашего проекта в панели управления.
# Не меняйте это значение без необходимости, оно используется дальше.
set :application,     'codenamecrud'

# Сервер размещения проекта.
set :deploy_server,   'phosphorus.locum.ru'

# Не включать в поставку разработческие инструменты и пакеты тестирования.
set :bundle_without,  [:development, :test]

set :user,            'hosting_frey'
set :login,           'frey'
set :use_sudo,        false
set :deploy_to,       "/home/#{user}/projects/#{application}"
set :unicorn_conf,    "/etc/unicorn/#{application}.#{login}.rb"
set :unicorn_pid,     "/var/run/unicorn/#{user}/#{application}.#{login}.pid"
set :bundle_dir,      File.join(fetch(:shared_path), 'gems')
role :web,            deploy_server
role :app,            deploy_server
role :db,             deploy_server, primary: true

# Следующие строки необходимы, т.к. ваш проект использует rvm.
set :rvm_ruby_string, '2.2.2'
set :rake,            "rvm use #{rvm_ruby_string} do bundle exec rake"
set :bundle_cmd,      "rvm use #{rvm_ruby_string} do bundle"

# Настройка системы контроля версий и репозитария,
# по умолчанию - git, если используется иная система версий,
# нужно изменить значение scm.
set :scm,             :git

# Предполагается, что вы размещаете репозиторий Git в вашем
# домашнем каталоге в подкаталоге git/<имя проекта>.git.
# Подробнее о создании репозитория читайте в нашем блоге
# http://locum.ru/blog/hosting/git-on-locum
# set :repository,      "ssh://#{user}@#{deploy_server}/home/#{user}/git/#{application}.git"

## Если ваш репозиторий в GitHub, используйте такую конфигурацию
set :repository, 'git@github.com:codenamecrud/codenamecrud.git'

## --- Ниже этого места ничего менять скорее всего не нужно ---

before 'deploy:finalize_update', 'set_current_release'
task :set_current_release, roles: :app do
  set :current_release, latest_release
end

set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})"

# - for unicorn - #
namespace :deploy do
  desc 'Start application'
  task :start, roles: :app do
    run unicorn_start_cmd
  end

  desc 'Stop application'
  task :stop, roles: :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc 'Restart Application'
  task :restart, roles: :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
  end
end

set :sitemaps_path, 'shared/'
task :refresh_sitemaps do
  run "cd #{latest_release} && RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle exec rake sitemap:refresh"
end

set :whenever_command, "RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle exec whenever"
