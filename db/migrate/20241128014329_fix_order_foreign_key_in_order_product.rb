class FixOrderForeignKeyInOrderProduct < ActiveRecord::Migration[8.0]
  def change
    change_column :order_products, :order_id, :bigint, null: false
  end
end
