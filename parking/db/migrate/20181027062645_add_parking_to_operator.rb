class AddParkingToOperator < ActiveRecord::Migration[5.2]
  def change
    add_reference :operators, :parking, foreign_key: true
  end
end
