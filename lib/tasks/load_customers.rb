f = File.new("cusomer.txt")
f.each do |customer|
  Customer.create!(:name => customer)
end