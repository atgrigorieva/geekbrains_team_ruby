class RemoveFixedFromRate < ActiveRecord::Migration[5.2]
  def change
    remove_column :rates, :fixed, :boolean
  end
end
