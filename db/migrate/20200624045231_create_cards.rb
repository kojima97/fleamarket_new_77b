class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.integer :card_id, null: false
      t.integer :customer, null: false
      t.integer :user_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
