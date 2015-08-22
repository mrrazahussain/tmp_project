class CreateCourseAuthors < ActiveRecord::Migration
  def change
    create_table :course_authors do |t|
      t.references :course
      t.references :user
      t.timestamps null: false
    end
  end
end
