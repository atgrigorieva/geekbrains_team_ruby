class CreateHistoryReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :history_reservations do |t|
      t.references :rate, foreign_key: true
      t.references :parking_place, foreign_key: true
      t.references :car, foreign_key: true
      t.datetime :date_in
      t.datetime :date_out

      t.timestamps
    end
  end
end
