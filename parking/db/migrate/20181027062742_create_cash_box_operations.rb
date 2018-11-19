class CreateCashBoxOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_box_operations do |t|
      t.string :name

      t.timestamps
    end
  end
end
