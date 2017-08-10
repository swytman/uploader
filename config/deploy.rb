set :application, 'uploader.ru'
set :repo_url, 'https://github.com/swytman/uploader.git'
set :deploy_to, '/var/www/uploader'
set :current_path,  "#{fetch(:deploy_to)}/current"
set :unicorn_conf, "#{fetch(:deploy_to)}/current/config/unicorn/#{fetch(:stage)}.rb"
set :unicorn_pid, "#{fetch(:deploy_to)}/shared/pids/unicorn.pid"
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{public/files}

# UNICORN


#NGINX
namespace :nginx do
  task :restart do
    on roles(:web) do
      execute "sudo service nginx restart"
    end
  end
  task :start do
    on roles(:web) do
      execute "sudo service nginx start"
    end
  end
  task :stop do
    on roles(:web) do
      execute "sudo service nginx stop"
    end
  end

end

# DB
namespace :db do
  task :migrate do
    on roles(:db) do
      execute "rake db:migrate RAILS_ENV=#{fetch(:rails_env)} --trace"
    end
  end
end

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end