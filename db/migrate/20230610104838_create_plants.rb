class CreatePlants < ActiveRecord::Migration[7.0]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :category
      t.string :description
      t.string :water_schedule
      t.string :location
      t.string :how_to
      t.integer :sunlight
      t.integer :size
      t.string :lifecycle

      t.timestamps
    end
  end
end
