class AddSlugsToArticlesAndRubrics < ActiveRecord::Migration
  def change
    add_column :articles, :slug, :string
    add_index :articles, :slug

    add_column :rubrics, :slug, :string
    add_index :rubrics, :slug
  end
end
