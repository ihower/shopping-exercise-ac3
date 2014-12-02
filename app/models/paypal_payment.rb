class PaypalPayment

  def self.find_by(order)
    self.new order, PayPal::SDK::REST::Payment.find(order.paypal_payment_id)
  end

  def initialize(order, payment)
    @order = order
    @payment = payment
  end

  def self.build(order, redirect_urls)
    self.new order, PayPal::SDK::REST::Payment.new({
        :intent => "sale",
        :payer => {
          :payment_method => "paypal"
        },
        :transactions => [{
          :item_list => {
            :items => [{
              :name => "shopping exercise",
              :price => order.total,
              :currency => "TWD",
              :quantity => 1 }]
          },
          :amount => {
            :total => order.total,
            :currency => "TWD"
          }
        }],
        :redirect_urls => {
          :return_url => redirect_urls[:return_url],
          :cancel_url => redirect_urls[:cancel_url],
        }
      })
  end

  def create
    is_success = @payment.create

    @order.paypal_payment_id = @payment.id
    @order.paypal_state = @payment.state
    @order.paypal_create_time = @payment.create_time
    @order.paypal_update_time = @payment.update_time

    if is_success
       @order.paypal_approval_url = @payment.links.detect{ |x| x.rel == 'approval_url' }.href
       @order.paypal_execute_url = @payment.links.detect{ |x| x.rel == 'execute' }.href
    else
      @order.paypal_error = @payment.error.to_json
    end

    @order.save!

    is_success
  end

  def execute
    is_success = @payment.execute( :payer_id => @order.paypal_payer_id )

    @order.paypal_state = @payment.state
    @order.paypal_update_time = @payment.update_time

    unless is_success
      @order.paypal_error = @payment.error.to_json
    end

    @order.save!

    is_success
  end

end