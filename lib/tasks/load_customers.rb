f = File.new("lib/customer.txt")
f.each do |customer|
  customer.chomp!
  Customer.create!(:name => customer)
end