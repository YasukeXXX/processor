lock "3.8.2"
set :application, "rails_app"
set :repo_url, "git@github.com:YasukeXXX/processor.git"
set :branch, 'master'
set :bundle_flags, "--quiet"
set :deploy_to, "/var/www/rails_application"
set :rbenv_path, '~/.rbenv'
set :rbenv_custom_path, '~/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_preload_app, false
set :prune_bundler, true

set :pty, true

append :linked_files, "config/database.yml", "config/secrets.yml", "config/puma.rb"
# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc 'restart puma'
  task :restart do
    Rake::Task["puma:stop"]
    Rake::Task["puma:start"]
  end

  desc 'Upload database.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('tmp/config/database.yml', "#{shared_path}/config/database.yml")
      upload!('tmp/config/secrets.yml', "#{shared_path}/config/secrets.yml")
    end
  end

  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'
end

# namespace :puma do
#   desc :add_port do
#     excute "echo 'port 3000' >> #{puma_conf}"
#   end
#   after 'puma:check', 'puma:add_port'
# end
