class CreateRateIntervals < ActiveRecord::Migration[5.2]
  def change
    create_table :rate_intervals do |t|
      t.string :name

      t.timestamps
    end
  end
end
