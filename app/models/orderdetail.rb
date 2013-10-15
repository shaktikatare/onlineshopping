class Orderdetail < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity
  belongs_to :order
  belongs_to :product
  
  def self.payable_amount(order)
    @amount=0
    order.orderdetails.each do |orderdetail|
      @amount = @amount + orderdetail.product.price * orderdetail.quantity
    end
    return @amount
  end
end
