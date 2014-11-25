class Cart

  attr_accessor :items

  def initialize
    @items = []
  end

  def add_item(product_id, qty)
    product_id = product_id.to_i
    qty = qty.to_i

    item = @items.find{ |x| x[:product_id] == product_id }
    if item
      item[:qty] += qty
    else
      @items << { :product_id => product_id, :qty => qty }
    end
  end

end