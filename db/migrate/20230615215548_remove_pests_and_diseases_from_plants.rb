class RemovePestsAndDiseasesFromPlants < ActiveRecord::Migration[7.0]
  def change
    remove_column :plants, :pests, :string
    remove_column :plants, :diseases, :string
  end
end
