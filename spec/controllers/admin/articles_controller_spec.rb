require 'spec_helper'

describe Admin::ArticlesController do


  def valid_attributes
    {'title' => 'MyString', 'short_description' => 'MyString', 'body' => 'My Body', 'language' => 'ru'}
  end

  describe 'with admin' do
    before(:each) do
      sign_in_admin
    end

    describe "GET index" do
      it "assigns all articles as @articles" do
        article = Article.create! valid_attributes
        get :index, {} 
        assigns(:articles).all.should eq([article])
      end
    end

    describe "GET show" do
      it "assigns the requested article as @article" do
        article = Article.create! valid_attributes
        get :show, {:id => article.to_param} 
        assigns(:article).should eq(article)
      end
    end

    describe "GET new" do
      it "assigns a new article as @article" do
        get :new, {} 
        assigns(:article).should be_a_new(Article)
      end
    end

    describe "GET edit" do
      it "assigns the requested article as @article" do
        article = Article.create! valid_attributes
        get :edit, {:id => article.to_param} 
        assigns(:article).should eq(article)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Article" do
          expect {
            post :create, {:article => valid_attributes} 
          }.to change(Article, :count).by(1)
        end

        it "assigns a newly created article as @article" do
          post :create, {:article => valid_attributes} 
          assigns(:article).should be_a(Article)
          assigns(:article).should be_persisted
        end

        it "redirects to the created article" do
          post :create, {:article => valid_attributes} 
          response.should redirect_to(admin_article_path(Article.last))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved article as @article" do
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          post :create, {:article => {"title" => "invalid value"}} 
          assigns(:article).should be_a_new(Article)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          post :create, {:article => {"title" => "invalid value"}} 
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested article" do
          article = Article.create! valid_attributes
          # Assuming there are no other articles in the database, this
          # specifies that the Article created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Article.any_instance.should_receive(:update).with({"title" => "MyString"})
          put :update, {:id => article.to_param, :article => {"title" => "MyString"}} 
        end

        it "assigns the requested article as @article" do
          article = Article.create! valid_attributes
          put :update, {:id => article.to_param, :article => valid_attributes} 
          assigns(:article).should eq(article)
        end

        it "redirects to the article" do
          article = Article.create! valid_attributes
          put :update, {:id => article.to_param, :article => valid_attributes} 
          response.should redirect_to(admin_article_path(article))
        end
      end

      describe "with invalid params" do
        it "assigns the article as @article" do
          article = Article.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          put :update, {:id => article.to_param, :article => {"title" => "invalid value"}} 
          assigns(:article).should eq(article)
        end

        it "re-renders the 'edit' template" do
          article = Article.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          put :update, {:id => article.to_param, :article => {"title" => "invalid value"}} 
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested article" do
        article = Article.create! valid_attributes
        expect {
          delete :destroy, {:id => article.to_param} 
        }.to change(Article, :count).by(-1)
      end

      it "redirects to the articles list" do
        article = Article.create! valid_attributes
        delete :destroy, {:id => article.to_param} 
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
        expect{delete :destroy, {:id => article.to_param}}.to change(Article, :count).by(0)
        response.should_not be_success
        response.should be_redirect
      end
    end

end
