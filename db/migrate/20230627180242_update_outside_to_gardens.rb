class UpdateOutsideToGardens < ActiveRecord::Migration[7.0]
  def change
    change_column :gardens, :outside, :string
  end
end
