class Order < ActiveRecord::Base

  belongs_to :user
  has_many :order_items

  before_save :setup_total

  protected

  def setup_total
    self.total = self.order_items.map{ |i| i.amount }.sum
  end

end
