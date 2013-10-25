class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :pictures, as: :imageable
  has_many :cart
  has_many :orderdetails, dependent: :destroy 
  validates :name, :price,:category_ids, presence: true
  attr_accessible :description, :name, :price, :category_ids, :pictures_attributes, :availability
  accepts_nested_attributes_for :pictures
  scope :available, where(:availability=>true)
  scope :unavailable, where(:availability=>false)
end
