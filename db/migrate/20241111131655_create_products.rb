class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    drop_table :products
    create_table :products do |t|
      t.timestamps
    end
  end
end
