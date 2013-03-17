require 'devise/test_helpers'

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end