class AddAdditionalInfoToGardens < ActiveRecord::Migration[7.0]
  def change
    add_column :gardens, :additional_info, :string
  end
end
