# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'my_app_name'
set :repo_url, 'git@github.com:andreibryk/travisci_test.git'

# Default branch is :master
set :branch, ENV["BRANCH_NAME"] || "feature/test_VH"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

set :ssh_options, {
  forward_agent: true,
  auth_methods: ["publickey"],
  keys: ["deployment/snapcarttest.pem"]
}

set :composer_install_flags, '--no-interaction'
set :symfony_directory_structure, 2
set :sensio_distribution_version, 4

set :permission_method, :acl
set :file_permissions_users, ["www-data"]
set :file_permissions_paths, ["app/cache"]

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

before "deploy:updated", "deploy:set_permissions:acl"

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
