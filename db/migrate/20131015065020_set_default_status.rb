class SetDefaultStatus < ActiveRecord::Migration
  def up
    change_column :orders, :order_status, :boolean, :default => false
  end

  def down
  end
end
