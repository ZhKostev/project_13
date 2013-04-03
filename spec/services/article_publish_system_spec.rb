require 'spec_helper'

describe ArticlePublishSystem do
  before(:each) do
    @article = FactoryGirl.create :article
  end

  describe 'make_clone method test' do
    it 'should make a new clone' do
      @article.front_clone.should be_nil
      expect { ArticlePublishSystem.new(@article).make_clone }.to change(Article, :count).by(1)
      @article.front_clone.should_not be_nil
    end

    it 'should clone rubrics' do
      ArticlePublishSystem.new(@article).make_clone
      @article.reload.front_clone.rubrics.to_a.should eq(@article.rubrics.to_a)
    end
  end

  describe 'make_or_update_clone method test' do
    it "should create a new clone if origin doesn't have clone" do
      @article.front_clone.should be_nil
      expect { ArticlePublishSystem.new(@article).make_or_update_clone }.to change(Article, :count).by(1)
      @article.front_clone.should_not be_nil
    end

    it 'should update title and rubrics' do
      ArticlePublishSystem.new(@article).make_clone
      @article.title = 'NEW TEST'
      @article.rubrics = [FactoryGirl.create(:rubric)]
      ArticlePublishSystem.new(@article).make_or_update_clone
      @article.reload.front_clone.rubrics.to_a.should eq(@article.rubrics.to_a)
      @article.front_clone.title.should eq('NEW TEST')
    end
  end

end

