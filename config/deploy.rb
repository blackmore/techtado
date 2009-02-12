default_environment["PATH"] = "/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin"

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