class AddRecommendedToPlants < ActiveRecord::Migration[7.0]
  def change
    add_column :plants, :recommended, :boolean
  end
end
