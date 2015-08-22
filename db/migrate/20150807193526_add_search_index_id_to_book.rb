class AddSearchIndexIdToBook < ActiveRecord::Migration
  def change
    add_column :books, :search_index_id, :string
  end
end
