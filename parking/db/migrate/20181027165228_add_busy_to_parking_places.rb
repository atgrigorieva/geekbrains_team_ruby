class AddBusyToParkingPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :parking_places, :busy, :boolean
  end
end
