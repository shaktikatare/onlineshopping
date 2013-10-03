class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :pictures, as: :imageable
  attr_accessible :description, :name, :price, :category_ids, :pictures_attributes
  accepts_nested_attributes_for :pictures
end
