class Order < ActiveRecord::Base
  attr_accessible :city, :full_name, :order_status, :phone, :pin_code, :shipping_address, :state, :user_id
  belongs_to :user
  has_many :orderdetail
end
