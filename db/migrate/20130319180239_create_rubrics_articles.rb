class CreateRubricsArticles < ActiveRecord::Migration
  def change
    create_table :articles_rubrics, :id => false do |t|
      t.references :article, :null => false
      t.references :rubric, :null => false
    end
    add_index(:articles_rubrics, [:article_id, :rubric_id], :unique => true)
  end
end
