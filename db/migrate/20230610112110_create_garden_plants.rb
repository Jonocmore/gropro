class CreateGardenPlants < ActiveRecord::Migration[7.0]
  def change
    create_table :garden_plants do |t|
      t.references :garden, null: false, foreign_key: true
      t.references :plant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :comment
      t.string :planting_date
      t.string :expected_harvest_date

      t.timestamps
    end
  end
end
