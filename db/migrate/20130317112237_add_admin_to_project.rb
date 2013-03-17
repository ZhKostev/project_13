class AddAdminToProject < ActiveRecord::Migration
  def up
    Admin.create(:email => 'admin@admin.com', :password => 'admin@admin.com', :password_confirmation => 'admin@admin.com')
  end

  def down
    Admin.destroy_all
  end
end

