class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.string :name
      t.boolean :fixed
      t.money :price
      t.datetime :date_from
      t.datetime :date_to

      t.timestamps
    end
  end
end
