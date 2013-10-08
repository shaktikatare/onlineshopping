class Cart < ActiveRecord::Base
  attr_accessible :product_id, :user_id, :qty
  belongs_to :user
  belongs_to :product
end
