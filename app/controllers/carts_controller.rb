class CartsController < ApplicationController

  def show
  end

  def create
    current_cart.add_item( params[:product_id], params[:qty] || 1 )

    redirect_to :back
  end

  def update
      params[:item].each do |product_id, qty|
        current_cart.update( product_id, qty )
      end

      redirect_to :back
  end

  def destroy
    pid = params[:product_id]
    current_cart.remove(pid)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js {
        render :text => "$('#product_#{pid}').remove();"
      }
    end
  end

end
