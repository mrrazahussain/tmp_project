class CreateTopicHierarchies < ActiveRecord::Migration
  def change
    create_table :topic_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :topic_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "topic_anc_desc_idx"

    add_index :topic_hierarchies, [:descendant_id],
      name: "topic_desc_idx"
  end
end
