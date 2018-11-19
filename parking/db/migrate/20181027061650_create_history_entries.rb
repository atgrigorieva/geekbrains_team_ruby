class CreateHistoryEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :history_entries do |t|
      t.references :car, foreign_key: true
      t.datetime :date_out
      t.datetime :date_in

      t.timestamps
    end
  end
end
