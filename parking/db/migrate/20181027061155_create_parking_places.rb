class CreateParkingPlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :parking_places do |t|
      t.references :parking, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
