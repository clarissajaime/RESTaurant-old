class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.integer :guests
      t.integer   :table_num

      t.timestamps
    end
  end
end
