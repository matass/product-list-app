class CreateProductTags < ActiveRecord::Migration[5.2]
  def change
    create_table :product_tags do |t|
      t.references :product, foreign_key: true
      t.references :tag, foreign_key: true

      t.datetime :discarded_at
      t.timestamps
    end

    add_index :product_tags, %i[product_id tag_id], unique: true
  end
end
