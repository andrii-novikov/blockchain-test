lock '~> 3.10.0'

set :application, 'blockchain-workshop'
set :repo_url,    'https://github.com/andy1341/blockchain-test.git'
set :use_sudo,    false
set :user,        'blockchain'

set :pty,             false
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/sites/#{fetch(:application)}"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :bundle_binstubs, nil

set :linked_files, %w{ config/database.yml config/secrets.yml.key }
set :linked_dirs,  %w{ log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads }

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'deploy:make_dirs', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Upload config'
  task :setup do
    on roles(:all) do
      upload!("config/database.yml", "#{deploy_to}/shared/config/database.yml")
      upload!("config/secrets.yml.key", "#{deploy_to}/shared/config/secrets.yml.key")
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'Upload robots.txt'
  before :restart, :upload_robots do
    on roles(:all) do
      upload!("public/robots.#{fetch(:rails_env)}.txt", "#{deploy_to}/current/public/robots.txt")
    end
  end

  desc 'Refresh sitemap'
  task :refresh_sitemap do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'sitemap:refresh'
        end
      end
    end
  end
end