class CreateProductPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :product_photos do |t|
      t.string :photo, null: false
      t.integer :product_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
