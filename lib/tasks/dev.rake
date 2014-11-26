task :fake => :environment do
  Product.create!( :name => "Book", :qty => 10, :price => 500)
  Product.create!( :name => "MacBook", :qty => 3, :price => 35000)
  Product.create!( :name => "House", :qty => 0, :price => 10000000)
  Product.create!( :name => "iPad", :qty => 1, :price => 10000)
  Product.create!( :name => "Nexus", :qty => 1, :price => 15000)
end

task :fake_many => :environment do

  100000.times do |i|
    Product.create!( :name => "Book #{i}", :qty => 1, :price => 10)
  end
end