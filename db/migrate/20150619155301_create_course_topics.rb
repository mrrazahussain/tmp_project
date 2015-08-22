class CreateCourseTopics < ActiveRecord::Migration
  def change
    create_table :course_topics do |t|
      t.references :course, index: true, foreign_key: true
      t.references :topic, index: true, foreign_key: true
      t.integer    :order
      t.timestamps null: false
    end
  end
end
