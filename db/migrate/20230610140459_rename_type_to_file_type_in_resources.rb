class RenameTypeToFileTypeInResources < ActiveRecord::Migration[7.0]
  def change
    rename_column :resources, :type, :file_type
  end
end
