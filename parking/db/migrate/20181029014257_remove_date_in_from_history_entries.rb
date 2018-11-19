class RemoveDateInFromHistoryEntries < ActiveRecord::Migration[5.2]
  def change
    remove_column :history_entries, :date_in, :datetime
    remove_column :history_entries, :date_out, :datetime

    add_column :history_entries, :date, :datetime
    add_column :history_entries, :action, :boolean
  end
end
