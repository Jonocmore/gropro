class AddColumnsToPlants < ActiveRecord::Migration[7.0]
  def change
    add_column :plants, :water_schedule, :string
    add_column :plants, :location, :string
    add_column :plants, :how_to, :string
    add_column :plants, :sunlight, :integer
    add_column :plants, :size, :integer
    add_column :plants, :lifecycle, :string
  end
end
