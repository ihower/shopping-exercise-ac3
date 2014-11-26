class OrderItem < ActiveRecord::Base

  belongs_to :order

  belongs_to :product

  after_save :setup_qty

  protected

  def setup_qty
    p = self.product
    p.qty -= self.qty
    p.save!
  end

end
