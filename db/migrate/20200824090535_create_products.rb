class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description
      t.decimal :price, null: false

      t.datetime :discarded_at
      t.timestamps
    end

    add_index :products, :name, unique: true
  end
end
