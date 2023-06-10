class CreateResources < ActiveRecord::Migration[7.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.string :text
      t.string :author
      t.integer :date
      t.string :type
      t.string :url

      t.timestamps
    end
  end
end
