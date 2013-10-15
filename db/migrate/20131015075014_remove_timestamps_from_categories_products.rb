class RemoveTimestampsFromCategoriesProducts < ActiveRecord::Migration
  def up
    remove_column :categories_products, :created_at
    remove_column :categories_products, :updated_at
  end

  def down
    add_column :categories_products, :updated_at, :string
    add_column :categories_products, :created_at, :string
  end
end
