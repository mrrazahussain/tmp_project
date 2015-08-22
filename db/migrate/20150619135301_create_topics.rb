class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.references :parent
      t.integer :sort_order

      t.timestamps null: false
    end
  end
end
