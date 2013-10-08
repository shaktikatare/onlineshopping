class CreateOrdersDetails < ActiveRecord::Migration
  def change
    create_table :orders_details do |t|
      t.integer :order_id
      t.integer :product_id

      t.timestamps
    end
  end
end
