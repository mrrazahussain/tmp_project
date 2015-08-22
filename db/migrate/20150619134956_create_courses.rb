class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.text :summary
      t.references :category, index: true, foreign_key: true
      t.attachment :image

      t.timestamps null: false    end
  end
end
