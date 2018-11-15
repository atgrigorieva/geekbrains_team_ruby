class AddParkingToHistoryOfCashbox < ActiveRecord::Migration[5.2]
  def change
    add_reference :history_of_cashboxes, :parking, foreign_key: true
  end
end
