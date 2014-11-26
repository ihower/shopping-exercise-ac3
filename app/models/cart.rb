class Cart

  attr_accessor :items

  def initialize
    @items = []
  end

  def add_item(product_id, qty)
    product_id = product_id.to_i
    qty = qty.to_i

    product = Product.find(product_id)

    item = @items.find{ |x| x[:product_id] == product_id }
    if item
      item[:qty] += qty
    else
      @items << { :product_id => product_id, :qty => qty }
    end

    refresh
  end

  def update(product_id, qty)
    product_id = product_id.to_i
    qty = qty.to_i

    item = @items.find{ |x| x[:product_id] == product_id }
    item[:qty] = qty

    refresh
  end

  def remove(product_id)
     @items.delete_if{ |x| x[:product_id] <= product_id.to_i }
  end

  def products
    @items.map{ |i|
      p = Product.find(i[:product_id])
      {
        :product_id => p.id,
        :name => p.name,
        :price => p.price,
        :qty => i[:qty],
        :amount => p.price * i[:qty]
      }
    }
  end

  def total
    products.map{ |p| p[:amount] }.sum
  end

  private

  def refresh
    @items.delete_if{ |x| x[:qty] <= 0 }
  end

end