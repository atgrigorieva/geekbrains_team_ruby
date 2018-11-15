class CreateOperators < ActiveRecord::Migration[5.2]
  def change
    create_table :operators do |t|
      t.references :user, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
