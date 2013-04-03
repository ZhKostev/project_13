require 'spec_helper'

describe Admin::ArticlesController do


  def valid_attributes
    rubric = FactoryGirl.create :rubric
    {'title' => 'MyString', 'short_description' => 'MyString', 'body' => 'My Body', 'language' => 'ru', 'rubric_ids' => [rubric.id]}
  end

  describe 'with admin' do
    before(:each) do
      sign_in_admin
    end

    describe "GET index" do
      it "assigns all articles as @articles" do
        article = FactoryGirl.create :article
        get :index, {}
        assigns(:articles).all.should eq([article])
      end
    end

    describe "GET show" do
      it "assigns the requested article as @article" do
        article = FactoryGirl.create :article
        get :show, {:id => article.to_param}
        assigns(:article).should eq(article)
      end
    end

    describe "GET new" do
      it 'assigns a new article as @article' do
        get :new, {}
        assigns(:article).should be_a_new(Article)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested article as @article' do
        article = FactoryGirl.create :article
        get :edit, {:id => article.to_param}
        assigns(:article).should eq(article)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Article' do
          expect {
            post :create, {:article => valid_attributes}
          }.to change(Article, :count).by(1)
        end

        it 'assigns a newly created article as @article' do
          post :create, {:article => valid_attributes}
          assigns(:article).should be_a(Article)
          assigns(:article).should be_persisted
        end

        it 'redirects to the created article' do
          post :create, {:article => valid_attributes}
          response.should redirect_to(admin_article_path(Article.last))
        end

        it 'should assign rubric' do
          post :create, {:article => valid_attributes}
          assigns(:article).rubrics.should_not be_empty
        end

        it 'should create clone when commit type is publish' do
          expect {
            post :create, {:article => valid_attributes, :commit => 'Publish'}
          }.to change(Article, :count).by(2)
          assigns(:article).front_clone.should be_a(Article)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved article as @article' do
          Article.any_instance.stub(:save).and_return(false)
          post :create, {:article => {'title' => 'invalid value'}}
          assigns(:article).should be_a_new(Article)
        end

        it "re-renders the 'new' template" do
          Article.any_instance.stub(:save).and_return(false)
          post :create, {:article => {'title' => 'invalid value'}}
          response.should render_template("new")
        end
      end
    end

    describe 'PUT update' do
      before(:each) do
        @article = FactoryGirl.create :article, :rubrics => [FactoryGirl.create(:rubric)]
      end

      describe 'with valid params' do
        it 'updates the requested article' do
          Article.any_instance.should_receive(:update).with({'title' => 'MyString2'})
          put :update, {:id => @article.to_param, :article => {'title' => 'MyString2'}}
        end

        it 'assigns the requested article as @article' do
          put :update, {:id => @article.to_param, :article => valid_attributes}
          assigns(:article).should eq(@article)
        end

        it 'redirects to the article' do
          put :update, {:id => @article.to_param, :article => valid_attributes}
          response.should redirect_to(admin_article_path(@article))
        end

        it 'should assign rubrics' do
          new_rubric = FactoryGirl.create :rubric
          put :update, {:id => @article.to_param, :article => valid_attributes.merge('rubric_ids' => [new_rubric.id])}
          assigns(:article).rubrics.should eq([new_rubric])
        end

        it 'should not update clone' do
          new_rubric = FactoryGirl.create :rubric
          ArticlePublishSystem.new(@article).make_clone
          old_rubrics = @article.rubrics.to_a
          old_title = @article.title
          put :update, {:id => @article.to_param, :article => valid_attributes.merge('rubric_ids' => [new_rubric.id],
                                                                                     'title' => 'NEW TITLE')}
          assigns(:article).rubrics.to_a.should eq([new_rubric])
          assigns(:article).title.should eq('NEW TITLE')
          assigns(:article).front_clone.rubrics.to_a.should eq(old_rubrics)
          assigns(:article).front_clone.title.should eq(old_title)
        end

        it 'should update clone' do
          new_rubric = FactoryGirl.create :rubric
          ArticlePublishSystem.new(@article).make_clone
          put :update, {:id => @article.to_param, :article => valid_attributes.merge('rubric_ids' => [new_rubric.id],
                                                                                     'title' => 'NEW TITLE'), :commit => 'Publish'}
          assigns(:article).rubrics.to_a.should eq([new_rubric])
          assigns(:article).title.should eq('NEW TITLE')
          assigns(:article).front_clone.reload.title.should eq('NEW TITLE')
          assigns(:article).front_clone.rubrics.to_a.should eq([new_rubric])
        end


        it "should create a clone if item hasn't got clone yet" do
          expect {
            put :update, {:id => @article.to_param, :article => valid_attributes, :commit => 'Publish'}
          }.to change(Article, :count).by(1)
        end
      end

      describe "with invalid params" do
        it 'assigns the article as @article' do
          Article.any_instance.stub(:save).and_return(false)
          put :update, {:id => @article.to_param, :article => {"title" => "invalid value"}}
          assigns(:article).should eq(@article)
        end

        it "re-renders the 'edit' template" do
          Article.any_instance.stub(:save).and_return(false)
          put :update, {:id => @article.to_param, :article => {"title" => "invalid value"}}
          response.should render_template("edit")
        end

        it "should re-renders the 'edit' template if user press publish" do
          Article.any_instance.stub(:save).and_return(false)
          put :update, {:id => @article.to_param, :article => {"title" => "invalid value", :commit => 'Publish'}}
          response.should render_template("edit")
        end
      end
    end

    describe 'DELETE destroy' do
      before(:each) do
        @article = FactoryGirl.create :article
      end

      it "destroys the requested article" do
        expect {
          delete :destroy, {:id => @article.to_param}
        }.to change(Article, :count).by(-1)
      end

      it "redirects to the articles list" do
        delete :destroy, {:id => @article.to_param}
        response.should redirect_to(admin_articles_url)
      end
    end
  end


  describe 'without user' do
    it 'index should not be accessible' do
      get :index
      response.should_not be_success
      response.should be_redirect
    end

    it 'show should not be accessible' do
      article = FactoryGirl.create :article
      get :show, {:id => article.to_param}
      response.should_not be_success
      response.should be_redirect
    end

    it 'new should not be accessible' do
      get :new
      response.should_not be_success
      response.should be_redirect
    end

    it 'create should not be accessible' do
      post :create, {}
      response.should_not be_success
      response.should be_redirect
    end

    it 'edit should not be accessible' do
      article = FactoryGirl.create :article
      get :edit, {:id => article.to_param}
      response.should_not be_success
      response.should be_redirect
    end

    it 'update should not be accessible' do
      article = FactoryGirl.create :article
      put :update, {:id => article.to_param}
      response.should_not be_success
      response.should be_redirect
    end

    it 'destroy should not be accessible' do
      article = FactoryGirl.create :article
      expect { delete :destroy, {:id => article.to_param} }.to change(Article, :count).by(0)
      response.should_not be_success
      response.should be_redirect
    end
  end

end
