# module for helping request specs
load "#{Rails.root}/spec/support/sign_in_helper.rb"

module SignInRequestHelper
  include SignInHelper
  # for use in request specs
  def sign_in_as_admin
    set_admin
    post_via_redirect new_admin_session_path, 'admin[email]' => @admin.email, 'admin[password]' => @admin.password
  end

end

RSpec.configure do |config|
  config.include SignInRequestHelper, :type => :request
end