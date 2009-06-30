load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

# I may be able to run this with cap propagate_customer_db
task :propagate_customer_db => :environment do
  f = File.new("lib/customer.txt")
  if User.count < 2
    f.each do |customer|
      customer.chomp!
      Customer.create!(:name => customer)
    end
  end
end