class OrdersDetails < ActiveRecord::Base
  attr_accessible :order_id, :product_id
  belongs_to :order
end
