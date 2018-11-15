class CreateHistoryOfCashboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :history_of_cashboxes do |t|
      t.references :history_reservation, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :date_payment
      t.money :cash
      t.references :cash_box_operation, foreign_key: true
      t.references :pay_type, foreign_key: true

      t.timestamps
    end
  end
end
