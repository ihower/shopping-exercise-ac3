class PaypalController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :update_paypal_data

  def webhook
    render nothing: true
  end

  def redirect
    redirect_to order_path(@order)
  end

  protected

  def update_paypal_data
    params.permit! # Permit all Paypal input params
    @order = Order.find(params[:invoice])
    @order.update_attributes paypal_params: params,
                             paypal_status: params[:payment_status],
                             paypal_transaction_id: params[:txn_id],
                             paid_at: params[:payment_date]
    # TODO: verify paypal params
  end

end
