require 'spec_helper'

describe "Admin::Rubrics" do
  describe "GET /admin_rubrics" do
    before(:each) do
      sign_in_as_admin
    end
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get admin_rubrics_path
      response.status.should be(200)
    end
  end
end
