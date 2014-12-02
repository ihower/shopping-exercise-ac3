class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new

    # TODO: use previous order information
    @order.receive_name = current_user.email
    @order.receive_address = current_user.email
  end

  def create
    @order = current_user.orders.new( order_params )

    current_cart.products.each do |p|
      @order.order_items.build( :product_id => p[:product_id],
                                :qty => p[:qty],
                                :amount => p[:amount] )
    end

    if @order.save
      current_cart.clear

      redirect_to @order.paypal_url
    else
      render :action => :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  protected

  def order_params
    params.require(:order).permit(:receive_name, :receive_address, :payment_type)
  end

end
