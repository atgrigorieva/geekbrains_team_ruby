class AddRateIntervalToRate < ActiveRecord::Migration[5.2]
  def change
    add_reference :rates, :rate_interval, foreign_key: true
  end
end
