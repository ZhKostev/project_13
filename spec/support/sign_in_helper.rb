module SignInHelper
  def set_admin
    Admin.where(:email => "admin@admin.com").destroy_all
    @admin = Admin.create!(:email => "admin@admin.com", :password => "password", :password_confirmation => "password")
  end

  def sign_in_admin
    set_admin
    sign_in @admin
    warden.set_user @admin
  end
end

RSpec.configure do |config|
  config.include SignInHelper, :type => :controller
  config.include SignInHelper, :type => :helper
  config.include SignInHelper, :type => :request
end