def load_customer
  f = File.new("/Users/nigel/Desktop/video_archive/lib/customer.txt")
  f.each do |customer|
    Customer.create!(:name => customer)
  end
end
