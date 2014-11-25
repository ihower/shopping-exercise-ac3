class CartsController < ApplicationController

  def create
    current_cart.add_item( params[:product_id], params[:qty] || 1 )

    redirect_to :back
  end

end
