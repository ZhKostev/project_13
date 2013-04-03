require 'spec_helper'

describe Article do
  before(:each) do
    @article = FactoryGirl.create :article
  end

  describe 'front_clone method test' do
    it 'should find by origin id' do
      clone = FactoryGirl.create :article, :origin_id => @article.id
      @article.front_clone.should eq(clone)
    end

    it 'should return nil if record not found' do
      @article.front_clone.should be_nil
    end
  end

  describe 'origin method test' do
    it 'should find by  id' do
      clone = FactoryGirl.create :article, :origin_id => @article.id
      clone.origin.should eq(@article)
    end

    it 'should return nil if record not found' do
      @article.origin.should be_nil
    end
  end
end
