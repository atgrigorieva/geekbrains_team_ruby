class AddRegionToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :region, :integer
  end
end
