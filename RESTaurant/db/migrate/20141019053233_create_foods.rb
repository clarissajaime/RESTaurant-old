class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 7, scale: 2
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
