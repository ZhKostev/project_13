class CreateAdminRubrics < ActiveRecord::Migration
  def change
    create_table :rubrics do |t|
      t.string :language
      t.string :title

      t.timestamps
    end
  end
end
