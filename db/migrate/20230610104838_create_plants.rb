class CreatePlants < ActiveRecord::Migration[7.0]
  def change
    create_table :plants do |t|
      t.string :plant_image
      t.string :plant_name
      t.string :crop_rotation_group
      t.string :soil
      t.string :position
      t.string :frost_tolerant
      t.string :feeding
      t.string :spacing_single_plant
      t.string :spacing_rows
      t.string :sow_and_plant
      t.string :notes
      t.string :harvesting
      t.string :water_schedule
      t.string :location
      t.string :how_to
      t.integer :sunlight
      t.integer :size
      t.string :lifecycle
      t.string :category

      t.timestamps
    end
  end
end
