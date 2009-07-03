namespace :db do
  task :load_customer_db => :environment do
  f = File.new("lib/customers.txt")
    if Customer.count < 2
      f.each do |customer|
        customer.chomp!
        Customer.create!(:name => customer)
        puts customer
      end
    end
  end
end
