class Order < ActiveRecord::Base

  belongs_to :user
  has_many :order_items

  before_save :setup_total

  validates_numericality_of :total, :greater_than => 0

  validate :check_enough_qty

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
