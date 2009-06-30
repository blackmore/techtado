load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

namespace :rake do
  desc 'Builds any native extensions for unpacked gems'
  task :customers_db_fill do
          run "rake :propagate_customer_db"
        end
end