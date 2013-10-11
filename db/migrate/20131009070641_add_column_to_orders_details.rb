class AddColumnToOrdersDetails < ActiveRecord::Migration
  def change
    add_column :orders_details, :quantity, :integer
  end
end
