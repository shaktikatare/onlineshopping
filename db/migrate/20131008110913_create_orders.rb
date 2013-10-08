class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer:user_id
      t.string :full_name
      t.string :shipping_address
      t.string :city
      t.string :state
      t.integer :pin_code
      t.string :phone
      t.boolean :order_status
     t.timestamps
    end
  end
end
