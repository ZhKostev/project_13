class AddOriginalIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :origin_id, :integer
    add_index :articles, [:origin_id], :name => "articles_origin_id_index"
  end
end
