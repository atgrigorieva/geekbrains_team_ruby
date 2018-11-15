class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :number
      t.string :driver_name

      t.timestamps
    end
  end
end
