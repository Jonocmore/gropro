class CreateGardens < ActiveRecord::Migration[7.0]
  def change
    create_table :gardens do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :date_planted
      t.string :location
      t.integer :sunlight
      t.integer :size
      t.boolean :outside

      t.timestamps
    end
  end
end
