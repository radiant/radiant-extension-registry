set :application, "radiant-extension-registry"
set :scm, :git
set :git_enable_submodules, true
set :deploy_via, :remote_cache
set :repository,  "git://github.com/radiant/radiant-extension-registry.git"
set :deploy_to, "/var/www/vhosts/radiantcms.org/subdomains/ext/app"
set :use_sudo, false

server "ext.radiantcms.org", :app, :web, :db, :primary => true

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

task :after_update_code do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
  run "ln -nfs #{deploy_to}/#{shared_dir}/public/system #{release_path}/public/system"
end
