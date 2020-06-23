class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :address_id
      t.integer :postal_code
      t.integer :prefecture_id
      t.string :city
      t.string :other
      t.string :building_name
      t.integer :user_id
      t.timestamps
    end
  end
end
