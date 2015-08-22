class CreateLearningStepRatings < ActiveRecord::Migration
  def change
    create_table :learning_step_ratings do |t|
      t.references :learning_step
      t.references :outcome
      t.integer :user_rating
      t.string :user_comment
      t.integer :author_rating
      t.integer :author_comment
      t.timestamps null: false
    end
  end
end
