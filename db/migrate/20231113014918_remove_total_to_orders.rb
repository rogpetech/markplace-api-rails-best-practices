class RemoveTotalToOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :total, :decimal
  end
end
