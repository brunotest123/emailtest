class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.belongs_to :restaurant, foreign_key: true
      t.string :name, null: false
      t.time :start_at, null: false
      t.time :end_at, null: false

      t.timestamps
    end
  end
end
