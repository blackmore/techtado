# Template created by You've Got Rails (http://www.youvegotrails.com)

gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com'
plugin 'rspec', :git => 'git://github.com/dchelimsky/rspec.git'
plugin 'rspec-rails', :git => 'git://github.com/dchelimsky/rspec-rails.git'
plugin 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git'
# Install gems on local system
rake('gems:install', :sudo => true) if yes?('Install gems on local system? (y/n)')

# Unpack gems into vendor/gems
rake('gems:unpack:dependencies') if yes?('Unpack gems into vendor directory? (y/n)')

# Run rspec generator
generate("rspec")


# Install and configure capistrano
run "sudo gem install capistrano" if yes?('Install Capistrano on your local system? (y/n)')

capify!

file 'Capfile', <<-FILE
  load 'deploy' if respond_to?(:namespace) # cap2 differentiator
  Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
  load 'config/deploy'
FILE


