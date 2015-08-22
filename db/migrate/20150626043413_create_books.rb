class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :edition
      t.text :summary
      t.attachment :file
      t.attachment :cover
      t.references :category
      t.timestamps null: false
    end
  end
end
