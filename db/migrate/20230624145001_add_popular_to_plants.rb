class AddPopularToPlants < ActiveRecord::Migration[7.0]
  def change
    add_column :plants, :popular, :boolean, default: false
  end
end
