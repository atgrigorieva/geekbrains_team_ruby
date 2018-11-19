class CreateParkings < ActiveRecord::Migration[5.2]
  def change
    create_table :parkings do |t|
      t.references :owner, foreign_key: true
      t.integer :number_of_places
      t.string :name

      t.timestamps
    end
  end
end
