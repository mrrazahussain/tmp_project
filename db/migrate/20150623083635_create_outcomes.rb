class CreateOutcomes < ActiveRecord::Migration
  def change
    create_table :outcomes do |t|
      t.text :content
      t.references :topic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
