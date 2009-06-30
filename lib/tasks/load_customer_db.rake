task :propagate_customer_db => :environment do
  f = File.new("lib/customer.txt")
  if User.count < 2
    f.each do |customer|
      customer.chomp!
      Customer.create!(:name => customer)
    end
  end
end

