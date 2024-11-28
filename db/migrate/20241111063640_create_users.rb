class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    drop_table :users
    create_table :users do |t|
      t.string :name

      t.timestamps
    end
  end
end
