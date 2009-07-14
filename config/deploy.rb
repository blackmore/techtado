set :ruby, "/usr/local/bin"
set :application, "techtado"
set :repository,  "git://github.com/blackmore/techtado.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
#set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:

set :scm, :git
set :runner, nil
server "10.1.1.211", :app, :web, :db, :primary => true, :user => 'nige'

#role :app, "your app-server here"
#role :web, "your web-server here"
#role :db,  "your db-server here", :primary => true


desc 'propagates the production MYSQL db with a lis of present customers'
task :load_customers, :roles => :db, :only => { :primary => true } do
    run "cd #{current_release} && " +
    "rake RAILS_ENV=production db:load_customer_db --trace" 
end

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
    run "god -c #{current_release}/config/get_mail.god"
  end

  task :stop, :roles => :app do
    run "god terminate"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "god terminate"
    run "touch #{current_release}/tmp/restart.txt"
    run "god -c #{current_release}/config/get_mail.god"
  end
end