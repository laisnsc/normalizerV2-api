class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    drop_table :orders
    create_table :orders do |t|
      t.datetime :date
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
