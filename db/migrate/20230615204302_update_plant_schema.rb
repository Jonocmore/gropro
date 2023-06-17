class UpdatePlantSchema < ActiveRecord::Migration[7.0]
  def change
    change_table :plants do |t|
      t.string "plant_image"
      t.string "plant_name"
      t.string "crop_rotation_group"
      t.string "soil"
      t.string "position"
      t.string "frost_tolerant"
      t.string "feeding"
      t.integer "spacing_single_plant"
      t.integer "spacing_rows"
      t.string "sow_and_plant"
      t.string "notes"
      t.string "harvesting"
      t.string "pests"
      t.string "diseases"
    end
  end
end
