f = File.new("customer.txt")
f.each do |customer|
  customer.chomp!
  Customer.create!(:name => customer)
end