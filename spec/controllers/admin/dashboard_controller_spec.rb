require 'spec_helper'

describe Admin::DashboardController do
  describe 'without user' do
    it 'dashboard should not be accessible' do
      get :index
      response.should_not be_success
      response.should be_redirect
    end
  end

  describe 'with admin' do
    before(:each) do
      sign_in_admin
    end

    it 'dashboard should be accessible' do
      get :index
      response.should be_success
    end
  end
end