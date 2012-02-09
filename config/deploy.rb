set :application, "mortgagescience"
set :repository,  "https://mobilefoundry.svn.beanstalkapp.com/ms-web/trunk/"
set :deploy_to, "/home/admin/deploy/#{application}"

server "www.ms.mobilefoundry.net", :app, :web, :db, :primary => true

namespace :deploy do

  desc "restarts apache"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "copy config files to release path"
  task :configure_app, :roles => :app do
    run "cp -R #{deploy_to}/config #{release_path}"
  end

  desc "symlinks the uploads directory to the current app path"
  task :symlink_uploads, :roles => :app do
    run "ln -nsf #{shared_path}/uploads #{release_path}/uploads"
  end

  desc "symlinks the jrxml directory to the current app path"
  task :symlink_jrxml, :roles => :app do
    run "ln -nsf #{shared_path}/jrxml #{release_path}/jrxml"
  end
end

after "deploy:update_code", 'deploy:configure_app'
after "deploy:update_code", 'deploy:symlink_uploads'
after "deploy:update_code", 'deploy:symlink_jrxml'
