class CreateLearningSteps < ActiveRecord::Migration
  def change
    create_table :learning_steps do |t|
      t.references :enrollment, index: true
      t.references :topic, index: true
      t.boolean :completed, default: false
      t.timestamps null: false
    end
  end
end
