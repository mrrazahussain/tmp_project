class AddDetailToTopics < ActiveRecord::Migration
  def change
    add_reference :topics, :course, index: true, foreign_key: true
    add_column :topics, :type, :string
  end
end
