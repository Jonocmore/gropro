class CreateRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.references :plant, null: false, foreign_key: true
      t.string :text
      t.string :trigger_conditions
      t.references :garden, null: false, foreign_key: true

      t.timestamps
    end
  end
end
