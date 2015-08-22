class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.integer :parent_id, index: true, foreign_key: true
      t.integer :position
      t.attachment :image

      t.timestamps null: false
    end
  end
end
