class AddPopularToResources < ActiveRecord::Migration[7.0]
  def change
    add_column :resources, :popular, :boolean
  end
end
