class RemoveColumnsFromPlants < ActiveRecord::Migration[7.0]
  def change
    remove_column :plants, :name, :string
    remove_column :plants, :category, :string
    remove_column :plants, :description, :string
    remove_column :plants, :water_schedule, :string
    remove_column :plants, :location, :string
    remove_column :plants, :how_to, :string
    remove_column :plants, :sunlight, :integer
    remove_column :plants, :size, :integer
    remove_column :plants, :lifecycle, :string
    remove_column :plants, :created_at, :datetime, null: false
    remove_column :plants, :updated_at, :datetime, null: false
  end
end
