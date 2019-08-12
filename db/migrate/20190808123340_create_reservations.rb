class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.belongs_to :shift, foreign_key: true
      t.belongs_to :table, foreign_key: true
      t.belongs_to :guest, foreign_key: true
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.integer :num_guests, default: 1

      t.timestamps
    end
  end
end
