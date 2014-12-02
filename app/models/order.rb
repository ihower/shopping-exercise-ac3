class Order < ActiveRecord::Base

  belongs_to :user
  has_many :order_items

  before_save :setup_total

  validate :check_enough_qty

  serialize :paypal_params

  # https://developer.paypal.com/docs/classic/paypal-payments-standard/integration-guide/wp_standard_overview/
  def paypal_url
    values = {
        business: Rails.application.secrets.paypal_account,
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}/paypal/return",
        invoice: id,
        amount: self.total,
        currency_code: "TWD",
        item_name: "shopping exercise",
        item_number: self.id,
        quantity: self.order_items.count,
        notify_url: "#{Rails.application.secrets.app_host}/paypal/webhook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end


  protected

  def check_enough_qty
    self.order_items.each do |item|
      errors[:base] << "#{item.product.name} is Sold Out" if item.qty > item.product.qty
    end
  end

  def setup_total
    self.total = self.order_items.map{ |i| i.amount }.sum
  end

end
