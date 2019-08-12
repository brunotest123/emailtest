class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :tables do |t|
      t.belongs_to :restaurant, foreign_key: true
      t.string :name, null: false
      t.integer :minimun_guest, default: 1
      t.integer :maximun_guest, default: 1

      t.timestamps
    end
  end
end
