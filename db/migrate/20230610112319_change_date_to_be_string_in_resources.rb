class ChangeDateToBeStringInResources < ActiveRecord::Migration[7.0]
  def change
    change_column :resources, :date, :string
  end
end
