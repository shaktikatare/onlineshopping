class Orderdetail < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity
  belongs_to :order
end
