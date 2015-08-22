class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :course
      t.references :user
      t.timestamps null: false
    end
  end
end
