class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :product_id, null: false
      t.string :name, null: false
      t.integer :price, null: false
      t.string :status, null: false
      t.string :brand
      t.text :explanation, null: false
      t.string :bear, null: false
      t.string :shipping_method, null: false
      t.string :area, null: false
      t.integer :ship_day, default: 0, null: false
      t.integer :user_id
      t.integer :category_id, null: false
      t.integer :exhibitor_user_id, foreign_key:true, null: false
      t.integer :buyer_user_id, foreign_key:true
      t.timestamps
    end
  end
end
