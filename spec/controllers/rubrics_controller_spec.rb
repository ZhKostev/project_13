require 'spec_helper'

describe RubricsController do

  describe 'GET index' do
    it 'should assign @rubric' do
      rubric = FactoryGirl.create :rubric
      get :index
      assign(:rubrics).all.should eq([rubric])
    end
  end

  describe 'GET show' do
    it 'should assign @rubric' do
      rubric = FactoryGirl.create :rubric
      get :show, {:id => rubric.to_param}
      assign(:rubric).should eq(rubric)
    end
  end
end