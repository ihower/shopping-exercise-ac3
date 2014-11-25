require 'rails_helper'

RSpec.describe Cart, :type => :model do

  let(:cart){ Cart.new }

  let(:p1){ Product.create!( :name => "A", :price => 100, :qty => 0) }
  let(:p2){ Product.create!( :name => "B", :price => 200, :qty => 2) }
  let(:p3){ Product.create!( :name => "C", :price => 300, :qty => 3) }

  it "should be empty cart" do
    expect(cart.items).to eq([])
  end

  describe ".add_item" do
    it "should add product to cart" do
        cart.add_item(p2.id, 1)
        expect(cart.items).to eq( [ { :product_id => p2.id, :qty => 1 }] )
    end

    it "should add two products to cart" do
        cart.add_item(p2.id, 1)
        cart.add_item(p3.id, 2)
        expect(cart.items).to eq( [ { :product_id => p2.id, :qty => 1 },
                                    { :product_id => p3.id, :qty => 2 }] )
    end

    it "should add the same product to cart" do
        cart.add_item(p2.id, 1)
        cart.add_item(p2.id, 1)
        expect(cart.items).to eq( [ { :product_id => p2.id, :qty => 2 } ] )
    end

    it "should raise error if product is not exist"
    it "should raise error if product is sold out"

  end

end
