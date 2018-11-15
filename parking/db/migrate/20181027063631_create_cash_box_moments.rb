class CreateCashBoxMoments < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_box_moments do |t|
      t.money :cash
      t.datetime :date
      t.references :parking, foreign_key: true

      t.timestamps
    end
  end
end
