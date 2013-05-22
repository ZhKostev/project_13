class CreateAdminArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :meta_description
      t.string :short_description
      t.string :language
      t.text :body

      t.timestamps
    end
  end
end
