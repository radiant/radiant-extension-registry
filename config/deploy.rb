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

  after "deploy:update_code", "deploy:link_database_config"
  task :link_database_config, :except => {:no_release => true} do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/production.sphinx.conf #{release_path}/config/production.sphinx.conf"
  end
end
