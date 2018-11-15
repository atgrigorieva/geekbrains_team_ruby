class AddParkingToRate < ActiveRecord::Migration[5.2]
  def change
    add_reference :rates, :parking, foreign_key: true
  
  end
end
