class AddPlantNameAndPlantImageToRecommendations < ActiveRecord::Migration[7.0]
  def change
    add_column :recommendations, :plant_name, :string
    add_column :recommendations, :plant_image, :string
  end
end
