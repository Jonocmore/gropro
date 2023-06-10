class CreateMassages < ActiveRecord::Migration[7.0]
  def change
    create_table :massages do |t|
      t.string :content
      t.references :forum, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
