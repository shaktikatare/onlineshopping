class Category < ActiveRecord::Base
  has_and_belongs_to_many :products
  before_destroy { products.clear }
  attr_accessible :name
  validates :name, presence: true
  
end
